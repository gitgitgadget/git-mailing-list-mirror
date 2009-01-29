From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Something weird is happening...
Date: Wed, 28 Jan 2009 22:24:36 -0800
Message-ID: <49814BA4.6030705@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 07:26:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSQLx-0001aT-19
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 07:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbZA2GYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 01:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbZA2GYv
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 01:24:51 -0500
Received: from terminus.zytor.com ([198.137.202.10]:58955 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbZA2GYv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 01:24:51 -0500
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id n0T6Ob2f017164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Jan 2009 22:24:38 -0800
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id n0T6Ob9n030591;
	Wed, 28 Jan 2009 22:24:37 -0800
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n0T6OaNm008633;
	Wed, 28 Jan 2009 22:24:36 -0800
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
X-Virus-Scanned: ClamAV 0.93.3/8916/Wed Jan 28 17:09:24 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107636>

I was investigating a problem that Ingo Molnar reported on the
linux-2.6-tip.git repository on kernel.org.  Unfortunately I was not
able to reproduce his problem (which is a problem in itself) but I did
run into another oddity:

: hera 4 ; git fsck

[lots of dangling commits deleted]
missing blob af0e01d4c663a101f48614e40d006ed6272d5c36

: hera 5 ; git cat-file blob af0e01d4c663a101f48614e40d006ed6272d5c36
/*
 *  debugfs.h - a tiny little debug file system
 *
 *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
 *  Copyright (C) 2004 IBM Inc.
 *
[... rest of blob deleted ...]

Okay, what is going on here?

Since git 1.6.1.1 just got installed on kernel.org, this phenomenon (and
hopefully Ingo's problem, too) maybe has something to do with this new
version?

	-hpa

--
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
