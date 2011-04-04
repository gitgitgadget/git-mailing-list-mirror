From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git exhausts memory.
Date: Mon, 4 Apr 2011 21:57:01 +0700
Message-ID: <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
 <alpine.LFD.2.00.1104021103130.28032@xanadu.home> <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
 <alpine.LFD.2.00.1104031110150.28032@xanadu.home> <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alif Wahid <alif.wahid@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 04 16:57:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6lDm-0002lY-D5
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 16:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab1DDO5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 10:57:33 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:48705 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610Ab1DDO5c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 10:57:32 -0400
Received: by pxi2 with SMTP id 2so2012132pxi.10
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=dPPcq0vUF1eM2CdKWg4PrJYJIE0Jmjy5Hd+1GSlQypE=;
        b=LOTSOWJDlfGUiqCzQqQaTNmv1Jrg9N8HKY8scgolvuNwlvaPHGHqBkPpwQzDd5Q2lR
         PH4saP18XtdpKqyuwJYNn2j3PSN8hrj7ghQFZzMdLV9Oa0RXyq2z/3D5Ix0a3kGWCt4Z
         rtCzaAb8gELDdxWbwqDH6Fzh5boSrv7bUrKRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=raxLLuRfyIX3OtATpkrBti4qvtWmvaVGJisU0/JSYv1o0cB5Rmfs3JJ9cnpslc0SiT
         zmpFK8zLZl9MdOuMEXczBmacuC2GB6ViFk2O1xr6gDaVWr+oRr13RXNp0ZKgOWmH14M3
         H5GAlGK8+GTZTyvmHSMzDjcewgBQ7ZbqU1bcM=
Received: by 10.143.87.1 with SMTP id p1mr6399501wfl.271.1301929052147; Mon,
 04 Apr 2011 07:57:32 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Mon, 4 Apr 2011 07:57:01 -0700 (PDT)
In-Reply-To: <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170814>

On Mon, Apr 4, 2011 at 7:52 PM, Alif Wahid <alif.wahid@gmail.com> wrote:
> Hi Nicolas,
>
> On 4 April 2011 01:18, Nicolas Pitre <nico@fluxnic.net> wrote:
>>
>> Something you can try is to simply tell Git not to attempt any delta
>> compression on those tar files using gitattributes (see the man page of
>> the same name).

Should we change the default to not delta if a blob exceeds predefined
limit (say 128M)? People who deliberately wants to delta them can
still set delta attr. 1.8.0 material maybe?

> Seems to have worked. Both git-gc and git-repack appear to be less
> memory hungry now and do actually run to completion without failure.
>
> Thanks for your help.
-- 
Duy
