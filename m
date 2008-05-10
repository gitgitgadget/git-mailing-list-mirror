From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 19/22] Added the class AddRuleListFactory.
Date: Sat, 10 May 2008 22:53:50 +0200
Message-ID: <200805102253.50641.robin.rosenberg.lists@dewire.com>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de> <1210424440-13886-20-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Sat May 10 22:56:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juw6O-0001SQ-57
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 22:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723AbYEJUyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 May 2008 16:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755831AbYEJUym
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 16:54:42 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12945 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755667AbYEJUym convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2008 16:54:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0F4C11434CC0;
	Sat, 10 May 2008 22:54:41 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eqIaE7H0k5Yp; Sat, 10 May 2008 22:54:40 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 97BE11434CBF;
	Sat, 10 May 2008 22:54:40 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1210424440-13886-20-git-send-email-florianskarten@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81703>

l=F6rdagen den 10 maj 2008 15.00.37 skrev Florian Koeberle:
> +class AddRuleListFactory {
> +	/*
> +	 * The add command of git 1.5.2.5 behaves a little bit stange: "git=
 add
> +	 * a/\*z" adds the file "a/b/xyz" but "git add a/x\*" does not.
> +	 *=20
> +	 * The first is parsed as pattern "*z" for whole directory tree "a"=
=2E The
> +	 * second is parsed as an path.
> +	 *=20
What do *you* do?

> +	 */
> +
> +	private static List<String> getRelativePath(File projectDirectory, =
=46ile file)
> +			throws PathNotInProjectDirectoryException, IOException {
> +		File currentFile =3D file.getCanonicalFile();
> +		final LinkedList<String> relativePath =3D new LinkedList<String>()=
;
> +		while (!currentFile.equals(projectDirectory)) {
> +			relativePath.addFirst(currentFile.getName());
> +			currentFile =3D currentFile.getParentFile();
> +			if (currentFile =3D=3D null) {
> +				throw new PathNotInProjectDirectoryException();
> +			}
> +		}
> +		return relativePath;
> +	}

Would be nice to have this logic in a utility class.

-- robin
