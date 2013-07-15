From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 3/6] diff: allow --patch & cie to override
 -s/--no-patch
Date: Mon, 15 Jul 2013 11:58:43 -0700
Message-ID: <20130715185843.GH14690@google.com>
References: <20130715173536.GB14690@google.com>
 <1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
 <1373910925-18422-4-git-send-email-Matthieu.Moy@imag.fr>
 <20130715180908.GE14690@google.com>
 <vpqvc4badhf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 15 20:58:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uynz2-0003jV-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 20:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab3GOS6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 14:58:48 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36097 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab3GOS6r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 14:58:47 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so10947554pdj.40
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 11:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ssalY9F+9m7oB8JC/w//umjvmDwmJ14sExTQ6VZoSuE=;
        b=vMUdIcrVSRIEcTbAwDjjsB9D6mYJQBlRn08EaWlE8y8JJ6EZUOKKIC8zKHXHHZfa0O
         1b46w7qrMYGeO1pUqoN6BYTTpJQytn6WFL+y+ly5uKL0dOrhzJUGKAhRoClp8xt9sWgR
         esBsHH23EcTmECVSr+8od+bu8isRrIWwjNMDpAFoEben4YCrKfhxXJMMcX6A4AOWKcbV
         ZjsYgapMSsbg+3KDHBNLumPtECnkUIIPhIVoPBjQaUcJnolo6xpEXPYFZTIyvijpDLR4
         8s/ji697d8i65M70pjYRSD0lx2bktbWOrsewJKhun8z9OXBtSds93wJrSKdmRSkvdvfE
         vGnw==
X-Received: by 10.66.25.45 with SMTP id z13mr57283071paf.151.1373914727172;
        Mon, 15 Jul 2013 11:58:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id mr3sm62292845pbb.27.2013.07.15.11.58.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 11:58:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqvc4badhf.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230515>

Matthieu Moy wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Matthieu Moy wrote:

>>> All options that trigger a patch output now override --no-patch.
>>>
>>> The case of --binary is particular as the name may suggest that it turns
>>
>> Usage nit: this should say "is unusual" 
>
> I don't get it. The point is not that --binary is unusual, but that it
> is a particular case that deserves extra attention.

Ah, so you mean: "The case of --binary deserves extra attention
because ...".

"is particular" would be an unusual expression, meaning something like
"is made of particles".  It's a weird case in English usage where a
word commonly appears attached to a noun ("This particular case") but
cannot be used as the RHS of "is" ("This case is particular").

[...]
>> A couple of other test ideas:
>>
>>  - "git diff-files --patch --no-patch"
>>  - "git diff-files -s --patch-with-stat"
>
> I'd rather avoid having a too long list here, or we'll end-up testing
> all combinations of options ...

Sure.  The point of "--patch --no-patch" is to test that ordering is
respected.  The point of "--no-patch --patch-with-stat" is so we
remember that there are options other than --patch that should
override --no-patch, for example if this code is ever converted to
parse_options some day.

> I'll send a reroll tomorrow.

Thanks for the quick and thoughtful work.
