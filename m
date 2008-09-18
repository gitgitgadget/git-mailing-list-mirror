From: Leevi Graham <info@leevigraham.com>
Subject: Help planning a git repo layout
Date: Thu, 18 Sep 2008 18:37:12 +1000
Message-ID: <938E7E5C-4FCB-4131-A5C4-254CEEC70673@leevigraham.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 10:39:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgF3G-00064e-GP
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 10:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbYIRIil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 04:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbYIRIil
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 04:38:41 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:57850 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYIRIik (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 04:38:40 -0400
Received: from spunkymail-a10.g.dreamhost.com (sd-green-bigip-202.dreamhost.com [208.97.132.202])
	by hapkido.dreamhost.com (Postfix) with ESMTP id B555C178491
	for <git@vger.kernel.org>; Thu, 18 Sep 2008 01:38:38 -0700 (PDT)
Received: from [192.168.1.2] (18.240.233.220.exetel.com.au [220.233.240.18])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by spunkymail-a10.g.dreamhost.com (Postfix) with ESMTP id D87951615DF
	for <git@vger.kernel.org>; Thu, 18 Sep 2008 01:37:15 -0700 (PDT)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96183>

Hey everyone,

I'm after some advice on how to layout my git repo(s).

Here's my current situation:

I am developing 10 different ExpressionEngine addons that all live  
inside one ExpressionEngine installation. A simplified EE installation  
has the following folders (all cruft removed):

|-root
   |-ee-admin
   |---extensions
   |---language
   |---modules
   |-themes
   |---site_themes

My addons are a combination of files located in the extensions,  
language, modules and themes folders. An simple extension may look like:

|-root
   |-ee-admin
   |---extensions
   |-----ext.lg_data_matrix.php
   |---language
   |-----english
   |---------lang.lg_data_matrix.php
   |---modules
   |-themes
   |---site_themes

The extension above contains two files:

- /ee-admin/extensions/ext.lg_data_matrix.php
- /ee-admin/language/english/ext.lg_data_matrix.php

I will be developing multiple extensions in the one EE install to make  
sure they all work with the core and do not conflict with each other.  
So my directory will have more than one addon in it:

|-root
   |-ee-admin
   |---extensions
   |-----ext.lg_data_matrix.php
   |-----ext.lg_minify.php
   |-----ext.lg_better_meta_ext.php
   |---language
   |-----english
   |---------lang.lg_data_matrix.php
   |---------lang.lg_minify.php
   |---------lang.lg_better_meta.php
   |---------lang.lg_better_meta_ext.php
   |---modules
   |-----lg_better_meta
   |---------mcp.lg_better_meta.php
   |---------mod.lg_better_meta.php
   |-themes
   |---site_themes

My problem comes when I want to tag and release an individual addon  
which is a collection of files in multiple folders.

Just say I wanted to tag and release LG Better Meta. Ideally I would  
like to export a folder structure like:

- /ee-admin/extensions/ext.lg_better_meta.php
- /ee-admin/language/english/ext.lg_better_meta.php
- /ee-admin/language/english/ext.lg_better_meta_ext.php
- /ee-admin/modules/lg_better_meta/mcp.lg_better_meta.php
- /ee-admin/modules/lg_better_meta/mod.lg_better_meta.php

I would also like to give people the ability to clone each of the  
addons either as a full repo or part thereof.

Any advice would be greatly appreciated.

Cheers Leevi
