From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3] git svn dcommit: new option --interactive.
Date: Sun, 18 Sep 2011 01:13:49 +0000
Message-ID: <20110918011349.GA22037@dcvr.yhbt.net>
References: <1316206921-29311-1-git-send-email-frederic.heitzmann@gmail.com>
 <1316261904.6897.9.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>
X-From: git-owner@vger.kernel.org Sun Sep 18 03:13:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R55xE-0002Ny-Dg
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 03:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab1IRBNv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Sep 2011 21:13:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44101 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab1IRBNu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 21:13:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29E611F45A;
	Sun, 18 Sep 2011 01:13:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1316261904.6897.9.camel@bee.lab.cmartin.tk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181590>

Carlos Mart=C3=ADn Nieto <carlos@cmartin.tk> wrote:
> On Fri, 2011-09-16 at 23:02 +0200, Fr=C3=A9d=C3=A9ric Heitzmann wrote=
:
> > Allow the user to check the patch set before it is commited to SNV.=
 It is
>=20
> Typo: SNV -> SVN

Thanks, fixed locally

> My perl-foo isn't strong enough to properly review the rest.

I also squashed the following cleanup:

--- a/git-svn.perl
+++ b/git-svn.perl
@@ -802,7 +802,6 @@ sub cmd_dcommit {
 	if (defined $_interactive){
 		my $ask_default =3D "y";
 		foreach my $d (@$linear_refs){
-			print "debug : d =3D $d\n";
 			my ($fh, $ctx) =3D command_output_pipe(qw(show --summary), "$d");
 			while (<$fh>){
 				print $_;


Otherwise things good to me.  Acked and pushed out to master of
git://bogomips.org/git-svn.git
