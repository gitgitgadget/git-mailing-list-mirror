From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: add patch view
Date: Sat, 29 Nov 2008 17:10:26 +0100
Message-ID: <200811291710.27891.jnareb@gmail.com>
References: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com> <1227966071-11104-2-git-send-email-giuseppe.bilotta@gmail.com> <bd6139dc0811290743s6cf8e534nddd8a09698ea22b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sat Nov 29 17:12:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6SR8-0005VH-9E
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 17:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbYK2QKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 11:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbYK2QKd
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 11:10:33 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:28002 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbYK2QKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 11:10:32 -0500
Received: by ey-out-2122.google.com with SMTP id 6so783434eyi.37
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 08:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=U1gxnX/fOB1lSomaslIZmlVzXbaib+8jiMPLAx5Tt3c=;
        b=jsz8YD/At9v+DJaWgJsF4j6RkUU48mPidueoLUhL1pOsIwIkeyxsFjy0vtB12xS4HF
         ninSvVsXGXY0DUl3WHQhRoEv30VxdconN4YP7JTBPMfP0G5gtlQOgG3r05/jJQCSTEf8
         MmZgco185uNqwrsAsAsY7cAQDduSs9NifvbG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HCQhWfjo+Oile1ogWn3jETHiTYTZoq4cdHRik+w7BiIMcZu/eQt8AwCHhqSitdioE7
         JbIJ0zYoIQu47OlKW/JN8mXsilxliEsqBA+8yyK7kb9NZBdq+oDoWgOVGFZA6VxgP5AJ
         wHZX1LS3lTSHkDRKhm13KNqLQLn193eP67Qyc=
Received: by 10.210.81.3 with SMTP id e3mr10297150ebb.112.1227975030213;
        Sat, 29 Nov 2008 08:10:30 -0800 (PST)
Received: from ?192.168.1.11? (abvh10.neoplus.adsl.tpnet.pl [83.8.205.10])
        by mx.google.com with ESMTPS id 3sm5133970eyj.41.2008.11.29.08.10.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 08:10:29 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <bd6139dc0811290743s6cf8e534nddd8a09698ea22b9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101916>

On Sat, 29 Nov 2008, Sverre Rabbelier wrote:
> On Sat, Nov 29, 2008 at 14:41, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:

> > Trying to use 'commitdiff_plain' output as input to git am results in
> > some annoying results such as doubled subject lines. We thus offer a new
> > 'patch' view that exposes format-patch output directly. This makes it
> > easier to offer patches by linking to gitweb repositories.
> 
> If this does what I think it does I would be very happy with this
> feature :). Only yesterday I wanted to link someone to a patch I put
> up on repo.or.cz, but instead ended up telling them to download the
> snapshot.

True. 'commitdiff_plain' wasn't good enough; what's more it suffers
from the same ambiguity as 'commitdiff', i.e. it is both means to
show diff _for_ a commit (perhaps selecting one of parents), and
showing diff _between_ two commits; the new 'patch' always shows
diff for a commit, or for a series of commits.

>
> As an additional feature request; would it be possible to have a view
> that exposes a patch that is directly applyable by the patch command?

Both new 'patch' ('patchset') and old 'blobdiff_plain' should be
directly applicable by patch and by git-apply.

-- 
Jakub Narebski
Poland
