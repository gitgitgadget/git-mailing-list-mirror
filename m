From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] completion: introduce __gitcomp_2 ()
Date: Sat, 4 Jan 2014 00:39:24 +0530
Message-ID: <CALkWK0nQ30fg0RjgKq9WSb2Mv9W8xQsK+wy9hzHt7RGpBbad-Q@mail.gmail.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
 <1388415138-11011-3-git-send-email-artagnon@gmail.com> <xmqqeh4qndxs.fsf@gitster.dls.corp.google.com>
 <CALkWK0mgqJFz1Lf_UVX8fdvnT+u+rp705dak7kXVFFBSr2bTQA@mail.gmail.com> <xmqqwqihlzuj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 20:10:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzA8U-0002vN-Uf
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 20:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbaACTKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 14:10:15 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:41906 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbaACTKF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 14:10:05 -0500
Received: by mail-ie0-f175.google.com with SMTP id x13so16329744ief.34
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 11:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=J9gljDAmBYgXBzRPsZH3vPQivomk/g4KASZuc6WcM0U=;
        b=zmw+F2Z/AXSqKmW0S9AgvIycJNFnz4y2PoegCyW7s/oNhQXq/wdHsv2tl9+dk8qpW3
         BLM6HJdtkz5lDx7mANmdrWX2TDsAUepPsb+R5KGFJUT+0lVCxKBR0nE2IRiDxS/xFHmW
         O+vAl2503ru+SNdL4CaM5sS2xDmZuuPKEGppGZ36XDlpVQU/D3sHiFWfI0r9nRo99yPg
         On7iYR67XZHj+Ddla/YvSLsnB0ZUp0A2Euv/4+fo7tFgkITD2xf207Yofxc5IYyLZNRX
         fPPcb1jL75b8ztx7fysYNbgxVbWSCT5WjCyOCu6IHWiPmbsqF5WteHs5Vpy4lTkyM519
         6q7A==
X-Received: by 10.42.44.9 with SMTP id z9mr281210ice.88.1388776204492; Fri, 03
 Jan 2014 11:10:04 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Fri, 3 Jan 2014 11:09:24 -0800 (PST)
In-Reply-To: <xmqqwqihlzuj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239927>

Junio C Hamano wrote:
> I am not sure what you are worried about $pfx; what does it do when
> you have strings with different prefix in COMPREPLY? If it breaks,
> then the answer is "don't do it then".
>
> Doesn't an array know its own length and give you a way to ask?

Right. I was just throwing counterpoints at the wall.

> Imagine if one is flipping 47 topic branches from 6 contributors
> whose names all begin with 'j'.  I can see that such a person would
> appreciate if "git config branch.j<TAB>" did not dump all 47 topics
> at once but offered "jc/ jk/ jl/ jm/ jn/ js/" instead, and then a
> follow-up completion of "git config branch.jk/<TAB>" expanded to
> names of topics from that single contributor "jk".  Wouldn't the way
> to give these be either to return these two-letter hierarchy names
> with slash as the suffix or to return list of two-letter plus a
> slash with an empty suffix?  Either way, that is using something
> different from a dot or a space, so that may count as the third, I
> guess.

Ah, after completing branch.jk/, we would want no suffix: so the
example definitely counts as a third "completion class". I agree with
your reasoning, and will rework the series to do the _append () thing
you suggested.

Thanks.
