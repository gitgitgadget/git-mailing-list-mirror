From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: cvs2git with  modules?
Date: Tue, 17 Jun 2008 06:21:42 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302389A59@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 17 13:38:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8ZVj-0001Lh-Hg
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 13:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697AbYFQLg4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2008 07:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755615AbYFQLg4
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 07:36:56 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:59200 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbYFQLgz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2008 07:36:55 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jun 2008 07:36:55 EDT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cvs2git with  modules?
Thread-Index: AcjQbFFu07OhxeR7SxOa3pPKswGfpw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85291>

Hi All,
	I'm trying to use cvs2svn in cvs2git mode to convert a repo with a num=
ber of modules. =20
Can anyone tell me how to keep that module structure in the new git rep=
o?  So, if in cvs there are two modules,=20
ModA and ModB, I want to see those two as top level directories in the =
git repo.

I've tried putting adding the projects in my options file as below, but=
 it puts the files ModA/* and ModB/* at the top level in the git repo.


run_options.add_project(
    r'/home/foo/cvsrepo/ModA,
    trunk_path=3DModA',
    symbol_transforms=3D[
        ReplaceSubstringsSymbolTransform('\\','/'),
        NormalizePathsSymbolTransform(),
        ],
    symbol_strategy_rules=3D[
        UnambiguousUsageRule(),
        BranchIfCommitsRule(),
        HeuristicStrategyRule(),
        HeuristicPreferredParentRule(),
        ],
    )

run_options.add_project(
    r'/home/foo/cvsrepo/ModB,
    trunk_path=3DModB',
    symbol_transforms=3D[
        ReplaceSubstringsSymbolTransform('\\','/'),
        NormalizePathsSymbolTransform(),
        ],
    symbol_strategy_rules=3D[
        UnambiguousUsageRule(),
        BranchIfCommitsRule(),
        HeuristicStrategyRule(),
        HeuristicPreferredParentRule(),
        ],
    )


--=20
=A0
Kelly F. Hickel
Senior Software Architect
MQSoftware, Inc
952.345.8677
kfh@mqsoftware.com
