From: Lea Wiemann <lewiemann@gmail.com>
Subject: git am with MIME
Date: Tue, 19 Aug 2008 17:50:14 +0200
Message-ID: <48AAEBB6.9070306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 17:51:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVTUP-0006J4-Re
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 17:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbYHSPuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 11:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbYHSPuP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 11:50:15 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:11169 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYHSPuO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 11:50:14 -0400
Received: by gv-out-0910.google.com with SMTP id e6so9036gvc.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=gXmgIOQnCj3sA3qjl9C/DKDTvToKFx5XDEWgYbSn9OM=;
        b=Od9a1fqw8X0k8FJGtvLvujvU7udHiHA++6qBqE77oYLpKH+LbN1N7RpuRFZLVKpd3x
         mEpBZ86FiR/9e28QJyXdQRCbFoYj1zUYfzCBZFWb63yxWv58INl1QhnGDyXhMOtO4zG/
         MiW1KFp8itOKEfTxxRhKoIzvaotS1fpCqGPYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding:from;
        b=ZFoK3wKeIWuSc/FP1uiTgR81AAoWkvYLAqHhr5KhXHZzDNWcmnKZa7KPumLnkVY1NH
         7xB10xuh1thxMIh0bc+WinUWzhTaqf1ERLG640K7GTZ4MBW20GfcXCALeeBMqe/OjNwr
         WCs5mZ/yl90orrU5FlvLCUgnicfcVidcz3u/E=
Received: by 10.187.228.6 with SMTP id f6mr527327far.59.1219161011382;
        Tue, 19 Aug 2008 08:50:11 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.210.90])
        by mx.google.com with ESMTPS id d13sm309522fka.3.2008.08.19.08.50.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 08:50:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080707 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92879>

There's still a problem with git am on the current next branch (which
includes the recent "mailinfo: re-fix MIME multipart boundary parsing"
patch):

$ wcat -q
'http://article.gmane.org/gmane.comp.version-control.git/91305/raw' | git am
fatal: `pos + len' is too far after the end of the buffer
$

It seems to be because of the (unusual?) way the patch uses MIME.  Just
wanted to post this so it doesn't get lost.

-- Lea
