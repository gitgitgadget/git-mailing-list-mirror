From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/7] submodule groups
Date: Wed, 11 May 2016 16:07:07 -0700
Message-ID: <CAGZ79kY3S6SmJOMQ7RAKw0yTvicY=Y1VRRGdm5uK9+Eb7W+Ykg@mail.gmail.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<xmqq4ma5l526.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 01:07:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0dDv-0002C8-7U
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 01:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbcEKXHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 19:07:10 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36564 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbcEKXHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 19:07:08 -0400
Received: by mail-io0-f177.google.com with SMTP id i75so68775123ioa.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 16:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=5LohdUN4hSgQ7PSN4szjObZTUcWrbkqSS98Z2vzD41U=;
        b=W5k+303iwI7ECrm7WrusJw0NmFCfPXkEy/09mh4wYxTObvRXf/ORe2KJEKiPp1Luin
         mdKYJp3uRn9rVIO7T0ypQy0Rs29tXqRP+VCXykNTLzIj4kwxa4IBxZGkcY0q4TXZRN+q
         xKM4n22CEM/elCmlChai0fIdSyMDQ3w1XV2L6mRnMv4i7zOVKpjFnOJSepK8sxcKiR3U
         tSbtspv7owH67gI+fZillKQyquWI9tuIoqiH4npRBmRMy07xzuh1Iu6QUJ7wqyUL9Zw5
         eqWX8zH2R/ZGsj51TMbsZtZbFpiMs4NJDLvpCdNly/7JCO21i4v3twB7Ir8WIgydsV4e
         LgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5LohdUN4hSgQ7PSN4szjObZTUcWrbkqSS98Z2vzD41U=;
        b=GrKuKKC7r0q+PtV2b8d0DQ1bIReqKr1fIamfnd45m7kbkw3ESuMBl3nY0e9O5BuEGj
         339tlfjiRvc3DFLJIukBshOZ72vqnbRsebgmf8TPut3DWLdNV5QYQ/rCsI75TMpOBXi1
         Ed5YoC4lBk1kHMS45iZtbGR8+jsuKfx1jLnFgu9LNLaLcYubFnZZrIyOhlw3JpKmnHEG
         b9LJR/G7td4vCDQxMxg74eSA0CwNjvCCZZp+SVS03P03Z/Tl3RckHppf5cdVIcmPbIWr
         Ivhv+oSHJJ7FbiXsa7OUKuBFO90dKdVI7/QES46QRom0CvzPUMB8GscH7cQ4OjngN/Hq
         j0/w==
X-Gm-Message-State: AOPr4FV9faWVQR3OQbo6Z8802ipTti1gllVIPy/Z3jZ8OyZ04SyTo4D3WKoXTLa/8vDdeAORkAEHUVLDLtPbFFY7
X-Received: by 10.107.161.68 with SMTP id k65mr5990976ioe.110.1463008027910;
 Wed, 11 May 2016 16:07:07 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 11 May 2016 16:07:07 -0700 (PDT)
In-Reply-To: <xmqq4ma5l526.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294374>

On Tue, May 10, 2016 at 7:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I started from scratch as I think there were some sharp edges in the design.
>> My thinking shifted from "submodule groups" towards "actually it's just an
>> enhanced pathspec, called submodulespec".
>
> Except for minor things I mentioned separately, overall, this seems
> quite cleanly done.

I disagree (now).

I started documenting the <submodulespec> as an extension of
the pathspecs. While I thought the logical OR was the right way to go,
I think it is wrong now. So there is stuff in tests like:

    git submodule--helper matches-submodulespec sub0 ./.
./:(exclude)*0 *label-sub0

which should test if the first argument (sub0) matches the submodulespec
which follows. And it matches sub0 by matching the label, although
we told it to ignore anything ending in 0

So I wonder if we rather want to extend the pathspec magic to
include properties of blobs (i.e. submodules):

    git <command> . :(sub-label:label-sub0) :(exclude)*0

would look much more powerful too me. Properties of blobs
may also be interesting for otherwise. Imagine looking for huge files
(in a bare repo, so you have to use Git and not your shell tools):

  git ls-files . :(file-size:>1024k)

>
> Looks very promising.
>

Thanks for the encouragement!

Thanks,
Stefan
