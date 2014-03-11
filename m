From: shawn wilson <ag4ve.us@gmail.com>
Subject: git $Id$ smudge filter
Date: Tue, 11 Mar 2014 17:21:51 -0400
Message-ID: <CAH_OBievh+7qe_warJD0_+O6V2=ES9Jjke1tAu4rL5BOKRHdTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 22:22:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNU7t-0005gF-QS
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 22:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbaCKVWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 17:22:13 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:48640 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbaCKVWN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 17:22:13 -0400
Received: by mail-vc0-f181.google.com with SMTP id id10so2867407vcb.26
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=ylOsfeayuFDNTx4vui8wf77n+JtVmdmubfb/GakSzJU=;
        b=SF8DXHi6DrEByPm3HzfadD/kIchdg4wHNz/uvOLQkKJNQwI3yFbv2QtYPMeXjRzGIE
         AY0udlCo7oJaj2DHmfUw4plW73qoNQaOb3ZBNRKdSvVMwYeECzbrbIfSawIiFbngD8yy
         Q+j+OuztGDXSoaS7TGzTBAy9NtJN4IbY7FB5N3RM+aQqGvjXqoMiRynXVy6/QGjtd0uP
         IQ9uvlUlyl71XIYp7DVpg66SAVKSHLchVFiapfQQ8/73WRjLbHFp+6ExL/j5xrtAfvjO
         CtnkU8qXzyBhng2PVa54YuwohudLJ/5p5pRaPxpnMdaD2lB0vuB04Qah0tPqXmeqQQPF
         9gsw==
X-Received: by 10.58.238.35 with SMTP id vh3mr29262505vec.16.1394572932146;
 Tue, 11 Mar 2014 14:22:12 -0700 (PDT)
Received: by 10.52.227.233 with HTTP; Tue, 11 Mar 2014 14:21:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243901>

Currently, I've got a perl script that modifies the Id line in a smudge filter:
[filter "ident-line"]
  smudge = /usr/local/bin/githook_ident-filter.pl %f

The problem I've noticed with smudge filters is that it leaves the
repo dirty. How do I fix this? I am basically trying to replicate the
behavior of CVS or SVN $Id$ line here.
