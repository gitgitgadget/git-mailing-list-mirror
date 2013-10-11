From: Paolo Giarrusso <p.giarrusso@gmail.com>
Subject: Re: Fwd: [PATCH] git-subtree: Avoid using echo -n even indirectly
Date: Fri, 11 Oct 2013 11:32:11 +0200
Message-ID: <CAAcnjCRVUDYvBqB++AjTdY+9gBLECLsV+bbU9z5JJPS5=tG1rA@mail.gmail.com>
References: <1381291045-98372-1-git-send-email-p.giarrusso@gmail.com>
 <CALUzUxovH5MTP1_DMigRx1Hp+X6v3_YdLK2vSG4KwRLNSDHN-w@mail.gmail.com>
 <CAAcnjCT1bdR+9kDW=q_326OhiSMm3_j-yOh0-ayTkObK3bZ3bQ@mail.gmail.com>
 <CAAcnjCQ+c=8wYZkqS7VzZ_bDDDkSwdQ3qdz77osrSpKDS9ON7Q@mail.gmail.com> <20131009211101.GM9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"David A. Greene" <greened@obbligato.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 11 11:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUZ5M-00058k-EL
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 11:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756973Ab3JKJcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 05:32:36 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:61139 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab3JKJcc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 05:32:32 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so3093103lab.5
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FhYLW0JGZwxZaOm1t1MMP3POABgGbNvydZpXk8p7FPA=;
        b=lwk9gpzLZbqKrvfRBfT5LGmHvBd1qXi6DIUblhgt6y2P38FhlERxqBBxmr1NOuKn4I
         SH1QrP6Tdq0MVdT8eciW5sPFHfUxGE4itTgJ3wds4zzn+nT8waZfxGenCjoGB70+fTce
         HXNnddIBKb/JFeEeqKnNJNjdE2ga2qDdoY1/pLMyEA3sxnN4aiLBIn+Zdd2VNn+7z4be
         Vc4I7AP28cLjJS7BuXxGgA5Mw5bUEmbUrzluEaYHQ3h8x22kE7iCR21zDx5UoJLTNnGc
         iiOcpy+7jRz8EzUwMaCAdXZKL7CnOAayuvnymUw/DU3tj6gZbvhmVJKkEDXxZlKuKZ91
         evzw==
X-Received: by 10.112.209.42 with SMTP id mj10mr370848lbc.44.1381483951155;
 Fri, 11 Oct 2013 02:32:31 -0700 (PDT)
Received: by 10.112.190.102 with HTTP; Fri, 11 Oct 2013 02:32:11 -0700 (PDT)
In-Reply-To: <20131009211101.GM9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235896>

On Wed, Oct 9, 2013 at 11:11 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Paolo Giarrusso wrote:
>
>> Seeing the email, I wonder whether there's hope something like that
>> can be preserved in an email, and whether the code should use some
>> escape sequence instead.
>
> Yes, please.  Mind if I amend it to
>
>         printf "%s\r" "$revcount/$revmax ($createcount)" >&2
>
> ?

Please do go ahead, by all means (arguably as a different commit, but
those are minor details).

> [...]
>>>         say()
>>>         {
>>>                 if [ -z "$quiet" ]; then
>>>                         echo "$@" >&2
>>>                fi
>>>         }
>
> I agree with the other reviewers that this should be fixed to use
> printf, too, but that's another topic.
Seconded.

-- 
Paolo G. Giarrusso - Ph.D. Student, Philipps-University Marburg
http://www.informatik.uni-marburg.de/~pgiarrusso/
