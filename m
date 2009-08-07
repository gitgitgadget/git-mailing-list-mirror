From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb giving me some warnings in Apache's error_log
Date: Fri, 07 Aug 2009 07:14:52 -0700 (PDT)
Message-ID: <m3my6bpv6v.fsf@localhost.localdomain>
References: <533D6DDF-4DAC-4A86-A6F7-95B54B77E48B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark A Rada <markrada26@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 16:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZQDn-0003So-DH
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 16:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439AbZHGOOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 10:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757419AbZHGOOx
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 10:14:53 -0400
Received: from mail-yw0-f183.google.com ([209.85.211.183]:52702 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbZHGOOx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 10:14:53 -0400
Received: by mail-yw0-f183.google.com with SMTP id 13so1981546ywh.15
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=x7P7LfyUDvLQk9tcqqvgUcE5HPyzLC2h3LVd1lA+Ms4=;
        b=kyy/rkEWWOvuEW/k153p5TBirWxHlhhUFOizhzBWJF9IojKjpEwWLKePyWO3EDLxPe
         l6XB2CZsqW3txN94m1JfT8zUZyYnpxmzRTa+5eQMrO/koww9RabX/X4mPiTeaY8ENCj9
         SMLWhG1V13fhct/Si95WFA9am+sux8u5dSf5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=i4HSITAg4yEuHD5ImJFd42cMOXzBi/BFjABGk3ZkOk0qAHicS18agABgufyfa/YwcX
         OGEMMLHyPCD8N5NCfeZ+eH7n5eOjo4c+lONPuNW4vXJuUI0R3AtJ0NbJuqHMKIFqwzo+
         K8GKir2i7YkF0Zec5gAINw9CNQRVV57zA8KYQ=
Received: by 10.100.42.19 with SMTP id p19mr346289anp.137.1249654493995;
        Fri, 07 Aug 2009 07:14:53 -0700 (PDT)
Received: from localhost.localdomain ([72.14.241.7])
        by mx.google.com with ESMTPS id 9sm3073127agc.22.2009.08.07.07.14.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 07:14:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n77EEnbV020079;
	Fri, 7 Aug 2009 16:14:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n77EEmo1020076;
	Fri, 7 Aug 2009 16:14:48 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <533D6DDF-4DAC-4A86-A6F7-95B54B77E48B@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125197>

Mark A Rada <markrada26@gmail.com> writes:

> It doesn't seem to cause any other problems, but I don't know if it is
> significant or not.
> 
> [Fri Aug  7 08:51:13 2009] gitweb.cgi: Variable "$project_maxdepth"
> may be unavailable at /var/www/private/gitweb/cgi-bin/gitweb.cgi line
> 2296.
> [Fri Aug  7 08:51:13 2009] gitweb.cgi: Variable "$projectroot" may be
> unavailable at /var/www/private/gitweb/cgi-bin/gitweb.cgi line 2304.
> 
> 
> Apache 2.2.12/ mod_perl 2.04/ perl 5.8.8

>From perldiag(1) manpage:

  Variable "%s" may be unavailable

    (W closure) An inner (nested) anonymous subroutine is inside a
    named subroutine, and outside that is another subroutine; and the
    anonymous (innermost) subroutine is referencing a lexical variable
    defined in the outermost subroutine.  For example:

      sub outermost { my $a; sub middle { sub { $a } } }

    If the anonymous subroutine is called or referenced (directly or
    indirectly) from the outermost subroutine, it will share the
    variable as you would expect.  But if the anonymous subroutine is
    called or referenced when the outermost subroutine is not active,
    it will see the value of the shared variable as it was before and
    during the *first* call to the outermost subroutine, which is
    probably not what you want.

    In these circumstances, it is usually best to make the middle
    subroutine anonymous, using the "sub {}" syntax.  Perl has
    specific support for shared variables in nested anonymous
    subroutines; a named subroutine in between interferes with this
    feature.

The warning is about 'wanted' anonymous subroutine passed to
File::Find::find.  The "middle" subroutine is git_get_projects_list,
and the "outermost" is mod_perl / ModPerl::Registry request loop.

We can't make git_get_projects_list anonymous, but anonymous
subroutine is not called or referenced outside git_get_projects_list,
nor it is called or referenced outside mod_perl request/event loop.

This warning is harmless... but I do not know how to silence it.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
