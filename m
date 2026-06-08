Received: from cventin.lip.ens-lyon.fr (cventin.lip.ens-lyon.fr [140.77.13.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD33655F1
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.13.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918019; cv=none; b=Fy4NfSs36EjCNyunIkIZicpGd0IT5d2CG6wjhJZADZpOORWKi3JZBkk27fW2AdanorDTDjEj1nwZdTlUWkK7dDJ0ynUEUup0Ken6s3wFw+ydfDkDeuA2AfatVmr1DOwg/fxgwmoHLTffZvsOG/pk0+o4lDxN6SSxSVxT3O/bWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918019; c=relaxed/simple;
	bh=sz00/VZsO+MVXT4PHmutXZbkB5UL/CVnqai+RXPIeWc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hxd5J4hH09h41769kPSWLH0DZ5dUMwLG1XgVUIHjonrcbHeWsZreLpZYAr39XnCk0V6TbP8cTS5x6k4uC6v25uD1aXdGUVj9lTwH+FFRM4J+lCwUorsecfEtJmfVTt0b+P1oOoNi+Ujrw3HXsmlawA+709+FQqFWCmLfkW6McGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=140.77.13.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from vlefevre by cventin.lip.ens-lyon.fr with local (Exim 4.99.4)
	(envelope-from <vincent@vinc17.net>)
	id 1wWY88-00000008byn-2RyO;
	Mon, 08 Jun 2026 13:26:56 +0200
Date: Mon, 8 Jun 2026 13:26:56 +0200
From: Vincent Lefevre <vincent@vinc17.net>
To: git@vger.kernel.org
Subject: inconsistent order of --diff-algorithm variants in man pages
Message-ID: <20260608112656.GI1082778@cventin.lip.ens-lyon.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.3.2+134 (513df32b) vl-188789 (2026-06-03)

In Documentation/diff-algorithm-option.adoc, which is used by the
git-blame(1) and git-diff(1) man pages:

`--diff-algorithm=(patience|minimal|histogram|myers)`::
        Choose a diff algorithm. The variants are as follows:
+
--
   `default`;;
   `myers`;;
        The basic greedy diff algorithm. Currently, this is the default.
   `minimal`;;
        Spend extra time to make sure the smallest possible diff is
        produced.
   `patience`;;
        Use "patience diff" algorithm when generating patches.
   `histogram`;;
        This algorithm extends the patience algorithm to "support
        low-occurrence common elements".
--

I think that using the same order in the --diff-algorithm line and
in the description that follows would be better, i.e.

  --diff-algorithm=(myers|minimal|patience|histogram)

FYI, the text was added in 07924d4d50e5304fb53eb60aaba8aef31d4c4e5e
in 2013, but without any explanation on this difference.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)
