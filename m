From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 2/3] unpack-trees: use 'cuddled' style for if-else cascade
Date: Wed, 13 Aug 2014 07:52:13 -0700
Message-ID: <CAL=YDWnpiUOiCTrDfcXFUUJc+uP77kfNNoN3VZ+7g2i0fvXu2A@mail.gmail.com>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>
	<1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
	<20140812235731.GD24621@google.com>
	<20140813000045.GF24621@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes.Schindelin@gmx.de, barkalow@iabervon.org,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 16:52:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHZuY-0004MP-No
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 16:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbaHMOwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 10:52:17 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:33326 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbaHMOwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 10:52:14 -0400
Received: by mail-vc0-f173.google.com with SMTP id hy10so14960981vcb.4
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WjCqkghgcN4DpMPLG72tjIRYEb4VEQaUI2FYenMo9KY=;
        b=gF4/DqLpMVBMwkKs3W3IvLr54LQZE0eSpGCRoNfFiul99YSSXIQBV9P65+bNlzTO4x
         SAGx/fl5nKYuz+6qy4Dy/bVmu0CcgIWXSVFDNMHwa2Wf5Wyb7SEYVRBZk2wWBhiIWIYJ
         aUJyqSUgCYfSPh8o3WV/HYo2n9SkEDKk0PHxDib7MMaS2gM72XTpTRJW+OhfLFVj21Cr
         DP8CFySMlEiBtmlyNBZ7aRxNejDJgSsmcB/3f0IaH6LUNhU4EOGBfnfHrZV6sH+oZgbl
         qnEgxCsPRgq3lX8gkWy9P2nfxmZnJNUACJHMrH+7gZQnpmoQoKmJ45+fXdJJvi1+pZXa
         QRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WjCqkghgcN4DpMPLG72tjIRYEb4VEQaUI2FYenMo9KY=;
        b=DLf7D0jLe1MCQbPV3ORZx0u1ruMzr4eH9NHiTXcraKAEC4HTYvnx2ZXsYVIvkkHWbZ
         AZ/5+LdTzd485+ev9PxpI3rqP2oeOcT4mhYkg/nPcj8Q0a2whD8x8EsyvLIpfuj7gB/9
         E3OEw4PKDMy1Ely7AiFl6Epqr/Nd4NN3DtS/j5nMKdBxSplvaMf6NofLlQa9jHtypbt8
         d5BAxgtk++878vFL9YHbMwKreo8Ekclfp8ZJd1shGbc9Ob3wIsAGKWXGhaYZDWYmU79K
         PKAU0MotggiwwrS0QsTFcydQVs52lgIe8r4ERhU3JHx+e8nQhwIqghkiLeEKeU/P6jaH
         J/8Q==
X-Gm-Message-State: ALoCoQnrGAnF2KolntPHougNhuEe7CHLTgYQPkrxLBTvp+azQrlHvHFgG4bjGt9MpEB2nmXkFDow
X-Received: by 10.52.34.209 with SMTP id b17mr3377063vdj.49.1407941533316;
 Wed, 13 Aug 2014 07:52:13 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Wed, 13 Aug 2014 07:52:13 -0700 (PDT)
In-Reply-To: <20140813000045.GF24621@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255212>

On Tue, Aug 12, 2014 at 5:00 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Match the predominant style in git by following K&R style for if/else
> cascades.  Documentation/CodingStyle from linux.git explains:
>
>   Note that the closing brace is empty on a line of its own, _except_ in
>   the cases where it is followed by a continuation of the same statement,
>   ie a "while" in a do-statement or an "else" in an if-statement, like
>   this:
>
>         if (x == y) {
>                 ..
>         } else if (x > y) {
>                 ...
>         } else {
>                 ....
>         }
>
>   Rationale: K&R.
>
>   Also, note that this brace-placement also minimizes the number of empty
>   (or almost empty) lines, without any loss of readability.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>

> ---
>  unpack-trees.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index f4a9aa9..187b15b 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1771,8 +1771,7 @@ int twoway_merge(const struct cache_entry * const *src,
>                                         return merged_entry(newtree, current, o);
>                         }
>                         return o->gently ? -1 : reject_merge(current, o);
> -               }
> -               else if ((!oldtree && !newtree) || /* 4 and 5 */
> +               } else if ((!oldtree && !newtree) || /* 4 and 5 */
>                          (!oldtree && newtree &&
>                           same(current, newtree)) || /* 6 and 7 */
>                          (oldtree && newtree &&
> @@ -1781,17 +1780,14 @@ int twoway_merge(const struct cache_entry * const *src,
>                           !same(oldtree, newtree) && /* 18 and 19 */
>                           same(current, newtree))) {
>                         return keep_entry(current, o);
> -               }
> -               else if (oldtree && !newtree && same(current, oldtree)) {
> +               } else if (oldtree && !newtree && same(current, oldtree)) {
>                         /* 10 or 11 */
>                         return deleted_entry(oldtree, current, o);
> -               }
> -               else if (oldtree && newtree &&
> +               } else if (oldtree && newtree &&
>                          same(current, oldtree) && !same(current, newtree)) {
>                         /* 20 or 21 */
>                         return merged_entry(newtree, current, o);
> -               }
> -               else
> +               } else
>                         return o->gently ? -1 : reject_merge(current, o);
>         }
>         else if (newtree) {
> --
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
