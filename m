From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Check for -amend as a common wrong usage of --amend.
Date: Thu, 24 Jan 2008 19:25:32 +0000
Message-ID: <20080124192532.GA3389@hashpling.org>
References: <1201198439-3516-1-git-send-email-pascal@obry.net> <alpine.LSU.1.00.0801241818441.5731@racer.site> <4798DE6A.1050201@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Thu Jan 24 20:26:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI7iJ-0000a2-6P
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 20:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbYAXTZo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 14:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754542AbYAXTZo
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 14:25:44 -0500
Received: from pih-relay05.plus.net ([212.159.14.132]:38230 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbYAXTZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 14:25:43 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1JI7hh-0006Xp-Be; Thu, 24 Jan 2008 19:25:37 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m0OJPXxY003717;
	Thu, 24 Jan 2008 19:25:33 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m0OJPWAn003716;
	Thu, 24 Jan 2008 19:25:32 GMT
Content-Disposition: inline
In-Reply-To: <4798DE6A.1050201@obry.net>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: cc86f4b0cbb41052fe12f4c076e40fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71653>

On Thu, Jan 24, 2008 at 07:52:26PM +0100, Pascal Obry wrote:
> Johannes Schindelin a =E9crit :
> >That is ugly.  In a source file which is by no means specific to=20
> >git-commit, you cannot possibly mean to check for "amend".
>=20
> Agreed :( I'll try to come with something better.
>=20
> Pascal.
>=20

Would this be better handled by a commit-msg hook.  E.g.:

test "$(cat $1)" =3D "end" && {
    echo >&2 Commit message is \"end\", possible mis-type of --amend
    echo >&2 Use --no-verify to really commit with this commit message
	exit 1
}
