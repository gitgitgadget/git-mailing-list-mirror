From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v4 09/45] sequencer: remove useless indentation
Date: Sun, 9 Jun 2013 20:17:24 +0200
Message-ID: <20130609181724.GA11516@paksenarrion.iveqy.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-10-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:14:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulk8f-0003Au-HX
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab3FISOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 14:14:45 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:55384 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab3FISOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:14:44 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so5536128lbh.7
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YlTdjPjR/72JeUoMcGXNBgQ7D6tMfya6zugfvjDlW+s=;
        b=wbKU/88m6caKF/mlO8juxbjVurn1V1sqmgvWXQoHEYEF4eWUkxydZf9egENakdNage
         FLLtm3HZlCFKOdX4w/8ZK6YRJwTg0p5FA6eS1em6kUzodGxk4A9Cw0B/aYsGUPs289aE
         qOQG6zBNqEcKiVw/C2mlkjT11tbuXCSMbTEWpPwQQ/g1ydbPP9tSfFNy+wFHT/yAQxLb
         pm3GBJPiiLptaHuSUuMcXjv5qD4JiJ/1NP96I1QyZjxfWACb3wFrlX0CHq4h8ctbHMgk
         dB695xEPiVXmYDjxyMw++tQNAYb39o2DmN5bCFSItKSgWYKAAf9RR2vxea8yQ7rAUf2T
         OOsA==
X-Received: by 10.112.34.209 with SMTP id b17mr4521993lbj.55.1370801682999;
        Sun, 09 Jun 2013 11:14:42 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id z9sm3087672lae.7.2013.06.09.11.14.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 11:14:42 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UlkBA-00031X-5S; Sun, 09 Jun 2013 20:17:24 +0200
Content-Disposition: inline
In-Reply-To: <1370796057-25312-10-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227081>

On Sun, Jun 09, 2013 at 11:40:21AM -0500, Felipe Contreras wrote:
> By using good ol' goto.
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

I don't see this as an indentation change but as a restructing of the
code. I would prefer something more like
"Replace early return with goto cleanup" (but better phrased).

The same goes for the next patch in this serie, I would prefer if the
shortlog tells what have been done, not how hard it was to do. Even
trivial changes can introduce bugs and when the commit message is just
that "this is trivial" it forces me to read the diff to know if that's
something that can effect me or not.

> +leave:
>  	free_message(&msg);
>  	free(defmsg);

leave: should be cleanup: or out: to conform with already written code.=
 I
suppose there will be a lot of those changes from now on and it will be
easier if the name of the cleanup-label always is the same.

Maybe small things to review, but I think those things will lead to a
better code-base in the long term.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
