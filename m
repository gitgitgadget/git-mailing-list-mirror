From: Michael Schubert <schu@schu.io>
Subject: [GSoC] Proposal - Finishing network support for libgit2
Date: Fri, 06 Apr 2012 18:36:22 +0200
Message-ID: <4F7F1B86.10102@schu.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: libgit2@librelist.org
X-From: git-owner@vger.kernel.org Fri Apr 06 18:38:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGCB9-00072Q-Br
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 18:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753Ab2DFQiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 12:38:01 -0400
Received: from schu.io ([178.77.73.177]:36003 "EHLO
	lvps178-77-73-177.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754717Ab2DFQh4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 12:37:56 -0400
Received: from [10.0.1.2] (f052148220.adsl.alicedsl.de [78.52.148.220])
	by lvps178-77-73-177.dedicated.hosteurope.de (Postfix) with ESMTPSA id 6851E14954005;
	Fri,  6 Apr 2012 18:37:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120328 Thunderbird/11.0.1
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194879>

Finishing network support for libgit2
=====================================

Introduction
------------

So far, libgit2 supports fetching objects over http://, git:// and
file://. This year's GSoC task is to finish network support for
libgit2, namely

* fetch over ssh (including an API for SSH key management),
* support for packing objects (indispensable for push),
* push over http, git and ssh.

The existing network code is written in a modular manner and allows to
be reused (regarding socket handling for example).


Outline
-------

1. Fetch over SSH: Evaluate existing SSH libraries regarding their
usability (licence compliant, small, platform independent) with
libgit2. Implement a transport module for SSH.

1.1 SSH key managment API: Implement an easy-to-use API for the
management of SSH keys. Example: managed keys could be stored within
the object database, addressable through special purpose references
or config options.

2. Support for packing objects: fully implement (port, where possible)
the required code to create packs. This is expected to be both the most
challenging and time-consuming part.

3. Push over all four transports: Implement push for libgit2.

For all code parts, tests should be written.


Timeline
--------

04/24 - 04/30: Discuss implementation details with the mentor(s), finish
planning.

05/01 - 05/20: Implement first version of SSH transport and key
management, refactor existing network code for future use where needed.

05/21 - 05/31: Start working on the pack-objects part, read / discuss
pack details etc.

06/01 - 06/30: Implement pack-objects.

07/01 - 07/31: Implement push over all four transports.

08/01 - 08/13: Finish and polish code where needed, write more tests.


About me
--------

I study Computer Science at FU Berlin, besides I do a Git-related part
time job for a SCM company. As a regular contributor to libgit2 , I'm
rather familiar with the community and the bigger part of the code
base. GSoC would allow me to both gain experience with "Git's network
stack" and to add an important yet missing core part to libgit2. This
is the first time I apply for GSoC.
