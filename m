From: "Olivier Van Acker" <cyberroadie@gmail.com>
Subject: gti-cvsserver fatal - Don't understand command UseUnchanged
Date: Fri, 14 Mar 2008 13:53:34 +0000
Message-ID: <57af99860803140653t6b3c4116y8549162631a5d675@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 14:54:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaAMT-0000DP-Op
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 14:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbYCNNxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 09:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYCNNxi
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 09:53:38 -0400
Received: from el-out-1112.google.com ([209.85.162.182]:61621 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbYCNNxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 09:53:37 -0400
Received: by el-out-1112.google.com with SMTP id v27so2470936ele.17
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=wu3mBDjnEMUQ2RY9MBOiis2r3azHIsGmnfsBuj+Yxb4=;
        b=ILyNtrJek6ADCsJMTyF5pXOuYv3fzBI4jMrdzerXGsqZXKgjBJGRkvEMYdMquwGfsZ4I1PwYZiGUT44iM1C/UZCRC7Z08wDi2wjCAM7EqV7FUjWEdvIrYFuhyVtDogv/4/sxkoeoUXl8lvmmvr7V09HAwExaJ2ry89v5xlX+i3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AkOG1GVH8l8dnX3PY5vPoG50MnvktxSGtrohj06GvYtVzNFzElf6SwZEwT5cpvijhgIqhdOrdXCXlAjD8yaxmqXZ+EHHcuUnk32TTUeAe1c4xYNyUkUau5WMwXeOFQMBzpeF7slLjT3riM68iZBekgL3en8vt06ZZenlH36KGXQ=
Received: by 10.142.107.1 with SMTP id f1mr4919046wfc.10.1205502814324;
        Fri, 14 Mar 2008 06:53:34 -0700 (PDT)
Received: by 10.142.13.2 with HTTP; Fri, 14 Mar 2008 06:53:34 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77226>

Hi,

I'm using an java implementation of cvs to access my git repository.
(The reason I have to use cvs is because the continuous integration
tool, TeamCity, I use doesn't know git)

Other cvs clients on the same computer work fine, however the
continuous integration tool with it's java cvs implementation fails
:-( The log of git-cvsserver gives the following error (The java cvs
client doesn't get a reply at all and just quits):

git-cvsserver log:

2008-03-13 13:37:13 : INFO  - --------------- STARTING -----------------
2008-03-13 13:37:13 : DEBUG - Temporary directory is '/tmp/RSuXzcgbiU'
2008-03-13 13:37:13 : DEBUG - req_validrequests
2008-03-13 13:37:13 : DEBUG - SEND : Valid-requests remove add status
Entry watchers ci tag log co Modified Questionable admin Root history
valid-requests Global_option Argumentx annotate Valid-responses
Unchanged Directory rlog Argument expand-modules diff editors update
2008-03-13 13:37:13 : DEBUG - SEND : ok
2008-03-13 13:37:13 : DEBUG - req_Root : /var/git/dragon3d.git
2008-03-13 13:37:13 : DEBUG - req_Validresponses : E M MT Updated
Checked-in ok error Clear-static-directory Valid-requests Merged
Removed Copy-file Mod-time Mode Kopt Template Set-static-directory
Module-expansion Clear-sticky Set-sticky New-entry Mbinary
EntriesExtra
2008-03-13 13:37:13 : FATAL - Don't understand command UseUnchanged


Now I don't now what is causing the error, the client or the server,
but this is how far I got.

And maybe this might help; the source code of the client:

http://www.docjar.com/html/api/allensoft/javacvs/client/CVSClient.java.html
(I'm guessing) Line 1995 sends the UseUnchanged command


Any help welcome,

PS and just as a side question; what continuous integration tools do
git user like to use?


Thanks,

Olivier
