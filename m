From: Frank Li <lznuaa@gmail.com>
Subject: possible code error at run_command.c
Date: Mon, 21 Dec 2009 14:46:41 +0800
Message-ID: <1976ea660912202246k45732bf2p111bbeb78047693e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 07:46:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMc2c-0002YF-4d
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 07:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbZLUGqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 01:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbZLUGqm
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 01:46:42 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:61538 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbZLUGql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 01:46:41 -0500
Received: by ywh12 with SMTP id 12so5357302ywh.21
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 22:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=GHJibp5yD2ZGYy8h/YXvuyjbAfwlkiycAzNRqfykpl8=;
        b=fA6GysnnnHzhqYkjPFOcn+5+1QWYqzNOJKcWR0hb6UuePk8phO04JM6F4O8YE/26Oc
         BIbbz73Hfm/GYyPmP0ZfXeLIEW7mJCrc67F68CiCD0UNByiDVSurt8mwMmg9yqk/04PC
         uNOnpBidjj2aiaTj0cs98yVPMvWVmQWQC5IIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=xXtqwMoVd1X9Xvft4zHX6LVdDGHMjM7Lynaz+IYUOH0P6l9AWJaxEr/z/9pyIU2rl/
         kmx+wquKXQ4uXj04KsKqMp12nwCW4DUfkK3gzs2jrmgWydGYB2DimCZe23SffLfkdgCo
         6F9WCI/1xN0QptT/GuqSZQh2cQ7c/8U8L5mhQ=
Received: by 10.150.46.21 with SMTP id t21mr10478173ybt.234.1261378001016; 
	Sun, 20 Dec 2009 22:46:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135540>

int start_command(struct child_process *cmd)
{
	int need_in, need_out, need_err;
	int fdin[2], fdout[2], fderr[2];
	int failed_errno = failed_errno;

I have not found failed_errno as global variable.
failed_errno = failed_errno means nothing.

It is possible coding error and should be
int failed_errno= 0 or
failed_errno=errno.
