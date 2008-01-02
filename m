From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git and securing a repository
Date: Wed, 02 Jan 2008 02:51:37 -0800 (PST)
Message-ID: <m3ir2co5s4.fsf@roke.D-201>
References: <477B39B5.5010107@advancedsl.com.ar>
	<31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com>
	<477B6199.6070601@advancedsl.com.ar>
	<ee77f5c20801020126n1776d625ya6928c2e4bfdf497@mail.gmail.com>
	<477B69ED.3090107@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: =?iso-8859-15?q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Wed Jan 02 11:52:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA1Co-0001tW-Gu
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 11:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbYABKvk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 05:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbYABKvk
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 05:51:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:56650 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbYABKvj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2008 05:51:39 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2507990ugc.16
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 02:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=jZhKaMOmzoDcSCoclxA1gzHDKpIYRwHz/8XOWHnnF/0=;
        b=nw4+DE3db388p+Iq7/zgkvDclUsHHnd6W0bYtNzPXQ0/9v8Rf9b6d+d/yKwbnDtKCCFaibWed3nHjx8E537Ug5/pAFrEJpP7gbeOJqVf++9xWNTudYn/+UfuPX1gFL187QrAPqQGlqrW6pOGF+Gh5a3MHdtYGNRprUiWAMMZDtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=p5msC70TtZSNvNwelYFmYEVhrLsLn2fjNJyKd4VEJgbKfNHq137WWg1DMecRHzEL9P8hoQhXMg2b6TQZjO6iyM4HmZkpiP4q+aL77q1cJgHaq+jk7XzCmGUVtlstQoN8Qdj3SY8PhvLfAjeOczFabF6JOGi2Esxef1SCBJs4G2Q=
Received: by 10.66.254.15 with SMTP id b15mr13909307ugi.76.1199271098324;
        Wed, 02 Jan 2008 02:51:38 -0800 (PST)
Received: from roke.D-201 ( [83.8.196.6])
        by mx.google.com with ESMTPS id o7sm15418217uge.71.2008.01.02.02.51.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Jan 2008 02:51:37 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m02Au29j010462;
	Wed, 2 Jan 2008 11:56:03 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m02Attkb010459;
	Wed, 2 Jan 2008 11:55:55 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <477B69ED.3090107@advancedsl.com.ar>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69472>

Gonzalo Garramu=F1o <ggarra@advancedsl.com.ar> writes:

> David Symonds wrote:
>>
>> You can do arbitrarily-fine-grained authentication via the
>> pre-receive hook.
>>
>=20
> Can you provide some more info?  Looking at the kernel.org git docs,
> the pre-receive hook seems very limited as no parameters are allowed.
> So I'm not sure how an authentication system could be created.
>=20
> It also seems to be a push hook only (not invoked on pulls).

Some of read-only (fetch only) access protocols do not support
authentication: http, ftp, rsync, git. Authentication is provided only
for access via ssh and for push via https (WebDAV).

There is example update hook in contrib/hooks, named update-paranoid,
which could be base of what you want. Note that you probably rather
use newer pre-receive hook instead of older update hook.

AFAIK both update and pre-receive hooks are invoked also on fetch...
but I might be mistaken.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
