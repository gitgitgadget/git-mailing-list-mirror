From: Olivier LE ROY <olivier_le_roy@yahoo.com>
Subject: Handling empty directories in Git
Date: Tue, 8 Apr 2014 07:47:22 -0700 (PDT)
Message-ID: <1396968442.95061.YahooMailNeo@web120806.mail.ne1.yahoo.com>
Reply-To: Olivier LE ROY <olivier_le_roy@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 08 16:47:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXXJG-0000O0-PJ
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 16:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbaDHOr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 10:47:27 -0400
Received: from nm20-vm4.bullet.mail.ne1.yahoo.com ([98.138.91.180]:47889 "EHLO
	nm20-vm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932247AbaDHOrY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Apr 2014 10:47:24 -0400
Received: from [98.138.226.176] by nm20.bullet.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 14:47:23 -0000
Received: from [98.138.101.167] by tm11.bullet.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 14:47:23 -0000
Received: from [127.0.0.1] by omp1078.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 14:47:23 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 89592.19723.bm@omp1078.mail.ne1.yahoo.com
Received: (qmail 18029 invoked by uid 60001); 8 Apr 2014 14:47:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1396968442; bh=iGHjQsAv1XhzxnFz4TkJZoGvpi2ncdYoCbCJESZWu0Q=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=HzTguhDTi65hD91e/7BPGJF46XqpcherRmkXvfTVj8QyfFQ9ZhzjMS3DLaoEO5uLf6VEeePh/JmwVOJVdhmbVU783j7BjCORcxLF1/E/UAIU2DGDEqNRdMU9cGVC+ndC8SRvFDZrUIm/yzMbmyTS03pjWpTkdAB8/4sAmvj7+xg=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=byvR+3Z5yVuP2gRGKlqGtmJyIrb6nIy6oGxCpI5IbH6/wNfTw3BUpfR9n4LlMJBdW0hHujrP0HAfQ36yRJEQV+t8Yy1ub+zsZNDPQS9W7fJaoRTOylXzZdmQz5XoUCCyid/7a/Nxuvcj6PJZM1+z31+p69l1Kkeg3/YPmBNxQvw=;
X-YMail-OSG: IFXkeM8VM1kNsQYBYWLp.94KqJzmdTF.ZuoEQDoFc8eZgUN
 Vu6qejeKee9gVjRpLc4uArTQmUxUuzjJSSr0oGUMqHjsGoIh7fp.LI2L6H02
 Olsm43jU6s7sCMkDsnrrhwq6OyYYkjssHCBjgX9IzBxcm1txNfyPYBisqr7Y
 FhU18v6aoqd8OiujL09tRLNsArcGqiSRbUWtJ8Qh6EIvvSBL.jAkJmGp07nH
 mZKA6NFloSMBti4a7eaJACmXp3AdxmubfyKx8qtnApDuoHbco6_BohQ_EQTq
 Tw__N_yL2nd5TRTT.C20Odb3YXYawcf9Ve4nizQBg5_1dC3B1TqL3Ah7e6OS
 sGa9DvBdp9f5n6zfBMux38Or6IdTHjYMCZwrj.uIYxfFXhh_sjuzvAEEfsIa
 Pyq.4pNmukZzTTP697rIyUITQjEkDlA9r4a1Bj7UFcoGyIXoOVU1DfsWd01h
 BlaEQCgClrCqE8PlMu6sBfSCtXySGTcJhy5ffRGBV7yJqvrLBmYhes2rvFIY
 y8jq7TYv8yaA3rmro.FJzEbFV2AVDm_uAN6g9u23laivWBSH1.vPq3s7lMA-
 -
Received: from [164.177.10.113] by web120806.mail.ne1.yahoo.com via HTTP; Tue, 08 Apr 2014 07:47:22 PDT
X-Rocket-MIMEInfo: 002.001,SGVsbG8sIAoKSSBoYXZlIGEgcHJvamVjdCB1bmRlciBTVk4gd2l0aCBjb250YWlucyBlbXB0eSBkaXJlY3Rvcmllcy4KCkkgd291bGQgbGlrZSB0byBtb3ZlIHRoaXMgcHJvamVjdCBvbiBhIEdpdCBzZXJ2ZXIsIHN0aWxsIGhhbmRsaW5nIGVtcHR5IGRpcmVjdG9yaWVzLgoKVGhlIHNvbHV0aW9uOiBwdXQgYSAuZ2l0aWdub3JlIGZpbGUgaW4gZWFjaCBlbXB0eSBkaXJlY3RvcnkgdG8gaGF2ZSB0aGVtIHJlY29nbml6ZWQgYnkgdGhlIEdpdCBkYXRhYmFzZSBjYW5ub3Qgd29yaywgYmVjYXVzZSBzb21lIHNjcmkBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.182.648
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245927>

Hello, 

I have a project under SVN with contains empty directories.

I would like to move this project on a Git server, still handling empty directories.

The solution: put a .gitignore file in each empty directory to have them recognized by the Git database cannot work, because some scripts in my projects test the actual emptiness of the directories.

Is there any expert able to tell me: this cannot be done in Git, or this can be done by the following trick, or why there is no valuable reason to maintain empty directories under version control?

Regards,

Olivier LE ROY
France
