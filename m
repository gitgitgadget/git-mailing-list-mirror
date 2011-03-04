From: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
Subject: Behavior of git ls-files
Date: Fri, 4 Mar 2011 18:38:31 +0100
Organization: Steinbeis Innovationszentrum Embedded Design und Networking
Message-ID: <691824945.20110304183831@stzedn.de>
Reply-To: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 18:38:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvYxc-0004ix-3Q
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 18:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759941Ab1CDRif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 12:38:35 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:56317 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759919Ab1CDRie convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 12:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1299260311; l=618;
	s=domk; d=stzedn.de;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:
	Reply-To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=u+u3Jm5UrxTacNohJsSpqZVgn+w=;
	b=nQU/nqcOQR/1lqhjHrW8g9L+nqGv8PmQqA6vut92ziRV8wBfNaI/ZXjN1ceXrLq29Ek
	L8LQRrck3rnRKC1xWH4NI7oScikZq0aTw6KlbvcicSoLg6qoEM2GOgzfdV9T/rMcakfXe
	EduEqCs2RUu+IKnxj/JhGcUVCKyd9n7Fu2I=
X-RZG-AUTH: :Jm0Bdkutd9+hmApeFfvVItwLAhvERWWdnqr6RNEtsBX+cJj9Jg197xtEQP6NGcQ=
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.7] (pd956be74.dip0.t-ipconnect.de [217.86.190.116])
	by post.strato.de (cohen mo63) (RZmta 25.5)
	with ESMTPA id 2067ecn24GUGpg for <git@vger.kernel.org>;
	Fri, 4 Mar 2011 18:38:31 +0100 (MET)
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168452>

Hi,

I want to list all files in a repository that are tracked, but shall be ignored
when following the patterns in .gitignore
I tried to do this by "git ls-files --exclude-standard -i" but it seems as if it
doesn't properly handle directory entries in .gitignore

The following example shall reproduce this issue:

> $ mkdir test
> $ cd test
> $ git init
> $ mkdir testdir
> $ touch testdir/test
> $ git add testdir/test
> $ git commit -m "add test"
> $ echo "testdir/" > .gitignore
> $ git ls-files --exclude-standard -i

Is the behavior of git ls-files correct or not?

Thanks,
Steffen
