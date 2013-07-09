From: =?iso-8859-1?Q?Saraj=E4rvi_Tony?= <Tony.Sarajarvi@digia.com>
Subject: Git --file doesn't override $HOME in version 1.8.1.2
Date: Tue, 9 Jul 2013 11:05:46 +0000
Message-ID: <C8A88C530F38AE47B22BDC434090CBB0ED26E0@IT-EXMB01-HKI.it.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 13:05:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVk2-0008Gs-OB
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 13:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab3GILFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 07:05:51 -0400
Received: from smtp1.digia.com ([82.118.214.156]:50121 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359Ab3GILFt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 07:05:49 -0400
Received: from smtp1.digia.com (unknown [127.0.0.1])
	by IMSVA80 (Postfix) with ESMTP id 73572370048
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 14:05:47 +0300 (EEST)
Received: from IT-EXCAS01-HKI.it.local (unknown [10.9.52.70])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by smtp1.digia.com (Postfix) with ESMTP id 65E7A370041
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 14:05:47 +0300 (EEST)
Received: from IT-EXMB01-HKI.it.local ([fe80::78ea:e84d:88b4:9f3d]) by
 IT-EXCAS01-HKI.it.local ([fe80::880f:35fb:7fe4:a7cf%14]) with mapi id
 14.02.0283.003; Tue, 9 Jul 2013 14:05:47 +0300
Thread-Topic: Git --file doesn't override $HOME in version 1.8.1.2
Thread-Index: Ac58lDNuzKSWXOyLSHmV48wyH4v0hQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.9.5.6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229945>

Using Ubuntu 13.04 with Git 1.8.1.2 I stumbled upon a problem using Puppet.

In Puppet we launch Git with the command: '/usr/bin/git config --file /home/qt/.gitconfig --get "user.name" "Qt Continuous Integration System"'
However, puppet logs: "fatal: unable to access '/root/.config/git/config': Permission denied".

Puppet is run as root, so HOME points to /root, but still -file should override the environment variable.

If the same command is run directly from terminal as root, it works as well.

With 1.8.3.2 the problem didn't reoccur.

-Tony
-------
Digia, Qt
