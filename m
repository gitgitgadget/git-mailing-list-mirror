From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 03/22] Added a class Project which represents a project directory and it's repository.
Date: Sat, 10 May 2008 22:45:16 +0200
Message-ID: <200805102245.16575.robin.rosenberg.lists@dewire.com>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de> <1210424440-13886-4-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Sat May 10 22:47:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juvy6-0006n9-Jh
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 22:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633AbYEJUqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 May 2008 16:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755575AbYEJUqK
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 16:46:10 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12873 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754032AbYEJUqI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2008 16:46:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0BB1E1434CBC;
	Sat, 10 May 2008 22:46:07 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tGxe7TzIKN3a; Sat, 10 May 2008 22:46:06 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 80EC51434CBB;
	Sat, 10 May 2008 22:46:06 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1210424440-13886-4-git-send-email-florianskarten@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81695>

l=F6rdagen den 10 maj 2008 15.00.21 skrev Florian Koeberle:
> Signed-off-by: Florian Koeberle <florianskarten@web.de>
> +public class GitPathConstants {
> +	/**
> +	 * The name of the repository directory in the project directory.
> +	 */
> +	public static final String REPOSITORY_DIRECTORY_NAME =3D ".git";
> +
> +	/**
> +	 * Contains the name of the objects directory in the repository dir=
ectory.
> +	 */
> +	public static final String OBJECTS_DIRECTORY_NAME =3D "objects";
> +
> +	/**
> +	 * Contains the name of the refs directory in the repository direct=
ory.
> +	 */
> +	public static final String REFS_DIRECTORY_NAME =3D "refs";
> +=09
> +	/**
> +	 * Contains the name of the HEAD file in the repository directory.
> +	 */
> +	public static final String HEAD_FILE_NAME =3D "HEAD";
> +
> +}

Some of these we have as constansts in the Constants class. We should u=
se them
and put the new ones there too. I think we have a few literals of our o=
wn that should
go there tool. Don't be afraid of proposing changes to other people's c=
ode. We don't
territories.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Project.java b=
/org.spearce.jgit/src/org/spearce/jgit/lib/Project.java
> new file mode 100644
> index 0000000..6e72486
> --- /dev/null
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Project.java
This term is also used by Eclipse and has a different meaning. Could we
use something else, maybe WorkTree?
> +public class ProjectFactory {

Let Repository be the factory.

> +		} catch (RuntimeException e) {
> +			repository.close();
> +			throw e;
> +		} catch (IOException e) {
> +			repository.close();
> +			throw e;
> +		}
Why not finally() handling all Exceptions?

-- robin
