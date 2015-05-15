From: Kelvin Li <ltwisabc@gmail.com>
Subject: Re: determine a linux kernel version of a patch file
Date: Fri, 15 May 2015 10:03:53 -0700
Message-ID: <1431709433.1401.9.camel@gmail.com>
References: <CAJmOuExq3WF26Gufr5bAA7w3=EMxJ80NKMXf8Dgi0TK7kVXStA@mail.gmail.com>
	 <vpqr3qicabd.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Pawel Por <porparek@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 15 19:04:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtJ1t-0005tM-7p
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 19:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbbEOREF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 13:04:05 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33034 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbbEORED (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 13:04:03 -0400
Received: by igbpi8 with SMTP id pi8so43569868igb.0
        for <git@vger.kernel.org>; Fri, 15 May 2015 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=bupkYqLY0TDAI+lt+1N4LyR/QwcfrUkAc+4vIx53J50=;
        b=TLkwC9TuITK68sWgIpU4knSGai4hHP47Q4tazOW1FafWPrGbdLPmrQHQ9BamPLvTv1
         F8nHXi6e/k/VKTKUFUxMLggzSuNCZUdPcc9khpRUDRhSwdPBrP44tJTpIiFmHT60iNm2
         Eoe9b7O6TAByJKPv8Pru7ya1oYzhW+zu3ed1u11gkeJ8D7LmmHkXgP8VS8bja/d+SS6d
         bPmEXeJ9AlP7u2KWsokSncFPTQckAcs/TTXQ7h8MpM0FO8N7HvHfJwLSXhn1LTa4AVsH
         pvVRJC9/FlzaReojREAV5FWWGx+eHRvm5mr2fQuxHygYADMZ+tQzeHhgnYOeJDZ7WCg0
         vH5A==
X-Received: by 10.68.92.5 with SMTP id ci5mr19911973pbb.109.1431709443110;
        Fri, 15 May 2015 10:04:03 -0700 (PDT)
Received: from qm ([2602:306:c410:23f0:6af7:28ff:fe6b:e591])
        by mx.google.com with ESMTPSA id he9sm2411008pbc.7.2015.05.15.10.04.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 10:04:02 -0700 (PDT)
In-Reply-To: <vpqr3qicabd.fsf@anie.imag.fr>
X-Mailer: Evolution 3.12.9-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269157>

On Fri, 2015-05-15 at 14:08 +0200, Matthieu Moy wrote:
> Pawel Por <porparek@gmail.com> writes:
> 
> > Hi,
> >
> > At the beginning I'm sorry if this post is completely unrelated to
> > this mailing list.
> > I'm trying to find the base linux kernel version from which a patch
> > has been created and posted to LKML.
> > Most patches contain the index line. Is it the well known git index
> > (staging area) ?
> 
> This is the id of the blob object corresponding to the _file_ being
> patched (index <from>..<to> <mode>). That's why you don't see it in git
> log: git log shows you ids for commit objects (which point to trees,
> which in turn points to blob).
> 
> See Johannes' answer for how you can get some possible commits.
> 

Come to think of it, why is that line named "index"? Conceptually, this
"diff header index" seems distinct from the "staging area index", but
calling both "index" is confusing, in my opinion.

Is there already a note about this in the docs somewhere? At the very
least, "git help diff" seems to happily use both senses of the word
without any acknowledgement that we're overloading it.

Thanks,
Kelvin
