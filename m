From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] gitweb: clarify search results page when no matching
 commit found
Date: Wed, 21 Jul 2010 10:23:11 -0500
Message-ID: <20100721152311.GA12726@burratino>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
 <iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
 <AANLkTilY0fYxKlWLYGU4f4ZtJzsMSSnIIi0YnywKU5DU@mail.gmail.com>
 <20100721000823.GD4282@burratino>
 <AANLkTinlXsbp0NdhmqvlrmBBqGuGOIkh6PzGYFnk05qv@mail.gmail.com>
 <20100721141140.GA12123@burratino>
 <AANLkTinhyFD4RhLLxS-jj-oX5VWqGyy7AiXJ3VJlcU2W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Erick Mattos <erick.mattos@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 17:24:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obb9o-0001Qi-1x
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 17:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070Ab0GUPYW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 11:24:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61382 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0GUPYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 11:24:21 -0400
Received: by wwj40 with SMTP id 40so2460763wwj.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 08:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZtNhwPkySupAoZW6NVSpv8EFh5lFt+02UxnrnSWgGfE=;
        b=bHMj2uxy9hyY2FhL9t+rNUphkCLwBK51BLQE+7FAvkNyL0XCX2O5epdCXjrWEXWLEc
         se/knU7mw8TS7mooY3lXa+/RW15/TtZ/SUb6UuA8ZZR1CRyl+LHPFvMYkKyxfM+BjOhx
         JuV8FpsPWEFOuhU5yTpXXlw099NZnpWk/iJzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=neztjJRGMhyDm0EtyvhrihYoCZFz7mgJsAMockdH0/Kv+NvZv3chHve0nuww/sAE6k
         D9LOfeyy9CWhvrHr/hoz1oWQVtlaVVjOdxQJjt5MKi8AiK6pe3WxLDC0Nlek/pxtWiG/
         NoOZz03HmmBhLUdS/QYQyxB/+69AnlzVApPuw=
Received: by 10.227.42.25 with SMTP id q25mr356005wbe.8.1279725859792;
        Wed, 21 Jul 2010 08:24:19 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a27sm52647361wbe.12.2010.07.21.08.24.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 08:24:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinhyFD4RhLLxS-jj-oX5VWqGyy7AiXJ3VJlcU2W@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151402>

Erick Mattos wrote:

> I did a search in gitweb
> (http://git.kernel.org/?p=3Dgit/git.git;a=3Dsummary) by commit
> e2007832552ccea9befed9003580c494f09e666e.
>=20
> Looks as gitweb's search is broken and giving false results.

Maybe something like the following would help.

-- 8< --
When searching commits for a string that never occurs, the results
page looks something like this:

	projects / foo.git / search                                     \o/
	summary | ... | tree            [commit] search: [ kfjdkas ] [ ]re
	first =E2=8B=85 prev =E2=8B=85 next

	Merge branch 'maint'

	Foo: a demonstration project

Without a list of hits to compare it to, the header describing the
commit named by the hash parameter (usually HEAD) may itself look
like a hit.  Add some text (=E2=80=9CNo match.=E2=80=9D) to replace the=
 empty
list of hits to avoid this confusion.

Noticed-by: Erick Mattos <erick.mattos@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cedc357..a47eed2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6522,12 +6522,13 @@ sub git_search {
 			$paging_nav .=3D " &sdot; next";
 		}
=20
-		if ($#commitlist >=3D 100) {
-		}
-
 		git_print_page_nav('','', $hash,$co{'tree'},$hash, $paging_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash);
-		git_search_grep_body(\@commitlist, 0, 99, $next_link);
+		if ($page =3D=3D 0 && $#commitlist =3D=3D 0) {
+			print 'No match.\n';
+		} else {
+			git_search_grep_body(\@commitlist, 0, 99, $next_link);
+		}
 	}
=20
 	if ($searchtype eq 'pickaxe') {
--=20
