From: Hartmut Goebel <h.goebel@goebel-consult.de>
Subject: migrating from svn: How to clean up history?
Date: Tue, 13 Dec 2011 15:53:09 +0100
Organization: Goebel Consult
Message-ID: <4EE766D5.5040702@goebel-consult.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 15:53:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaTjI-0004Lb-G4
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 15:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab1LMOxM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Dec 2011 09:53:12 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:36810 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869Ab1LMOxL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 09:53:11 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 470C31801C34
	for <git@vger.kernel.org>; Tue, 13 Dec 2011 15:53:10 +0100 (CET)
Received: from station.goebel-consult.de (host-188-174-151-95.customer.m-online.net [188.174.151.95])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPS id 5AD661C0010F
	for <git@vger.kernel.org>; Tue, 13 Dec 2011 15:53:10 +0100 (CET)
Received: from lenashee.goebel-consult.de (lenashee.goebel-consult.de [192.168.110.2])
	by station.goebel-consult.de (Postfix) with ESMTP id E8F2D85F26FB2
	for <git@vger.kernel.org>; Tue, 13 Dec 2011 15:53:33 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Mandriva/3.1.16-0.1mdv2010.2 (2010.2) Lightning/1.0b2 Thunderbird/3.1.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187024>

Hello,

I'm one of the developers of www.pyinstaller.org, a tool for=20
bundling/packagin Python scripts and al required modules into a single=20
executable for easy distribution. We are in the process of migrating=20
from Subversion to git.

Our SVN-Repo contains some stuff we do not want or do not need in the=20
git repo. How can we clean this up?

1) Useless commits e.g. tagging -> I want to remove these
2) copy or move mistakes -> I want to "correct" the copy

Example for 1): This occurs e.g. if this is done

svn cp trunk tags/v0.1 -m 'release v0.1' <<<--- this on in not needed
svn rm tags/v0.1 -m 'release v0.1'
svn cp trunk tags/v0.1 -m 'release v0.1'

In this case I want to completely eliminate the first commit.

Example for 2): This occurs e.g. if this is done

svn cp trunk tags/v0.1 -m 'release v0.1'
svn cp trunk tags/v0.1 -m 'release v0.1' <<-- actually copies to=20
tags/v0.1/trunk

In this case I want to change eliminate the first commit (this is he=20
same as case 1) and rewrite commit 2 to rewrite the path.

I already did some experiments with `git filter-branch` without success=
=2E=20
(I manage renaming the tags, though.)

Any hints how to to this clean-up?

--=20
Sch=F6nen Gru=DF - Regards
Hartmut Goebel
Dipl.-Informatiker (univ.), CISSP, CSSLP

Goebel Consult
Spezialist f=FCr IT-Sicherheit in komplexen Umgebungen
http://www.goebel-consult.de

Monatliche Kolumne: http://www.cissp-gefluester.de/
Goebel Consult ist Mitglied bei http://www.7-it.de
