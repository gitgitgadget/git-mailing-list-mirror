From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: For first push to a bare repo, using "--tags" prevents creation of master branch
Date: Fri, 29 May 2015 08:21:22 -0700
Message-ID: <xmqq617bflzh.fsf@gitster.dls.corp.google.com>
References: <CABRuA+iVRZR9SxvYVCO5zd0hZEbn6tioyP6dZ5xSbaAeNF4w+w@mail.gmail.com>
	<vpqbnh4hro7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Darling <darlingm@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 29 17:21:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyM6F-0002gf-B3
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 17:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbbE2PV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 11:21:27 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34346 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500AbbE2PV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 11:21:26 -0400
Received: by igbhj9 with SMTP id hj9so17310210igb.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1Zrs58pIFomaSZmCVVB8AXeIDXaE8/h+Xx6E/888rHs=;
        b=ETZZzQSa7FFGL4ltNnhA3NlYg9utsmqGTGPDH+nPPRAvGdTc2oJLcTI+elWNbRFUZm
         ebnW5LY7aPm0i7gB9cdyXz8LleLrnxfRc87aavhUcu1jGja6BkTMZejRt9xHsY4HJZ9P
         1qBI+aoRlHmYdvEJx48B9chcMGCP4sr1lE/MGg/smPcv2+JsLzKqZLb6qQXfjZbRkNIs
         8Ph9lGm77XJV7/geU14JdpNCDJV1u5eNAKAxHZd5VPXXKVoN3ek8eUx3anpbmu02eHPa
         S3MEtIqLThIl1JGi9RABhHTY5c1X2GFhKK9NUOi7ts09T7QAJTRYW7+ASLW2qIuCqGz0
         TOtg==
X-Received: by 10.42.208.139 with SMTP id gc11mr8527930icb.84.1432912885399;
        Fri, 29 May 2015 08:21:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id r4sm1709532igh.9.2015.05.29.08.21.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 08:21:24 -0700 (PDT)
In-Reply-To: <vpqbnh4hro7.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	29 May 2015 07:35:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270242>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> You did not provide any refspec (you provided <repository> but not
> <refspec>), hence --tags pushes only tags. So, this is the expected
> behavior.

Right.

> That said, we may want to add an option like --tags-also that would push
> tags _in addition_ to what would normally be pushed. --follow-tags does
> more or less this, though, but only for annotated tags pointing at a ref
> being pushed.

Yeah.  I am not sure --tags-also is necessarily a good thing (I do
not think "fetch --tags" is a good thing, either).  If --follow-tags
does not touch lightweight ones, that may be a bug we would want to
fix.  I did not mean to implement --follow-tags that way, and I do
not offhand remember if there was a reason to omit lightweight ones.

Thanks.
