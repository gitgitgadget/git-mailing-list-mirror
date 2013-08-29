From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] Add proper 'stage' command
Date: Thu, 29 Aug 2013 13:47:21 -0500
Message-ID: <521f9739dad63_16921225e7477096@nysa.mail>
References: <20130829180129.GA4880@nysa>
 <1377799744-5201-1-git-send-email-felipe.contreras@gmail.com>
 <1377799744-5201-2-git-send-email-felipe.contreras@gmail.com>
 <vpq8uzks5ou.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:54:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7M0-0003kY-R7
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515Ab3H2Sx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:53:56 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:37459 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab3H2Sxz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:53:55 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so928550obb.15
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=E8NA7UuYirl5N9XOcabBBUZryXENITLTksEfD7oW34E=;
        b=aqimz8oim52VBgH2pafewgk1UDglkCZkQ5x5LEtA0/SjvF8MxtAgoyMhrwKM5Kkrl8
         vlAUXj9Ae2teeDTps6BZO8+VG18d2Sw5Ccmh5ipTt8zmKlFK/a+9v5F0L1AY5DmPt2tK
         fukV0mTJ8nwhnEebXGxzWZxmpY+hKVfRp3pnVnSO3wTy8+yaNkpqTSBouUFYacBSTA7O
         LgAWFbkNC+taMsm8vYRgih0LJx7c+jZk37AXDDkmicXWpePPwgc51dBz6kHTUiqiNbtt
         v6t6BaBWgqglYPkR/sVWjyqPZO1tZltr5xqvLsZ5WBMiUxwt2cN7O5tXTwQHR3XP/R9n
         0RoA==
X-Received: by 10.60.62.4 with SMTP id u4mr3647610oer.35.1377802435297;
        Thu, 29 Aug 2013 11:53:55 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ps5sm34011310oeb.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:53:54 -0700 (PDT)
In-Reply-To: <vpq8uzks5ou.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233336>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > +COMMANDS
> > +--------
> > +
> > +With no arguments, it's a synonym for linkgit:git-add[1].
> 
> This would not be very useful since "git add" errors out when called
> without arguments ;-).

Right.

> The accurate description of your code would be closer to "When the first
> argument is not a subcommand, it's a synonym for linkgit:git-add[1].".
> I'm not sure I like it, as it creates ambiguities (e.g. need to spell
> "git stage -- diff" to add a file called "diff". Not a strong objection
> though, as we already have refs Vs filename ambiguities in many places.

Yes, I thought really hard about this, but I think it's the best alternative.
In adition, we could stat to see if there's a file with the same name as the
assumed subcommand, and warn about the ambiguity, and the recommended way to
add the file.

-- 
Felipe Contreras
