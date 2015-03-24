From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: per-repository and per-worktree config variables
Date: Tue, 24 Mar 2015 20:48:49 +0700
Message-ID: <CACsJy8CYgMDY_zGi6o=UtD7QV+DQUcaDgwxo6tGrfktRXj+QSw@mail.gmail.com>
References: <1423401394-13675-1-git-send-email-pclouds@gmail.com>
 <54D79EAB.6060301@web.de> <20150318213342.GA25692@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 14:49:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaPD3-00046t-67
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 14:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbbCXNtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 09:49:22 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33413 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbbCXNtV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 09:49:21 -0400
Received: by iecvj10 with SMTP id vj10so60577885iec.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pmUpkcGvicle4972khRo9nC2oQCnyhtgK702tuLjYzg=;
        b=fvqDU/V5qe1Z5JpFW7CrXF8s6ZZXWmbAExCaM6jo+Wx1fCvEIeVlSWFHuEPFqHYuIH
         g2DmwE9B+UBm5qQoKIPGGEwPvRIcH3JZth+gfKbsPsSXt6fm9waqMK1eIoRF4zNm0lXR
         ZDs1S0KWxRxy1MKkkw4p0Sp4YtLgz3ueGKEmUFk83nmQ2Qa8SYeE15Y+HoZHZcsfXRis
         1u/Fw4GZJb1M27b3ywjskTQ8FxAgD+4GGBGPOfCLTBgjyC2pRF2vqqzQRQNRPw3U7nNp
         vze4Jq2K7b54Iqc0l0zcMZWR7gZrNH+BcCd4VNngvpZdC1d3I9RHCtayTKGha8Fws8We
         WRYQ==
X-Received: by 10.50.57.78 with SMTP id g14mr3153981igq.41.1427204960995; Tue,
 24 Mar 2015 06:49:20 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Tue, 24 Mar 2015 06:48:49 -0700 (PDT)
In-Reply-To: <20150318213342.GA25692@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266188>

On Thu, Mar 19, 2015 at 4:33 AM, Max Kirillov <max@max630.net> wrote:
> On Sun, Feb 08, 2015 at 09:36:43AM -0800, Jens Lehmann wrote:
>> I wonder if it's worth all the hassle to invent new names. Wouldn't
>> it be much better to just keep a list of per-worktree configuration
>> value names and use that inside the config code to decide where to
>> find them for multiple work trees. That would also work easily for
>> stuff like EOL-config and would push the complexity in the config
>> machinery and not onto the user.
>
> I actually thought about the same, and now tend to think
> that most of config variables make sense to be per-worktree
> in some cases. Only few variable must always be per
> repository. I tried to summarize the variables which now
> (in current pu) should be common, also listed all the rest
> so somebody could scan through the list and spot anything I
> could miss.

Thanks for compiling the list. At this point I think it may not be
sensible to hard code some config vars (e.g. core.worktree) to be
local or shared. So I'm thinking (out loud) that we may have a file
$GIT_DIR/worktrees/<id>/local-config-patterns (or some other name)
that would define what vars are local. gitignore syntax will be reused
for this. The file would provide more flexibility..
-- 
Duy
