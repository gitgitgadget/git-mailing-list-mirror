From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: test suite work-around for python 2.5 requirement
Date: Wed,  2 Jun 2010 18:23:14 -0500
Message-ID: <injaoVtrfs7Li4aYBNxEQXkF9MAEkifYLJqrBJp5DqE7xic9MCOmsuM0PlcTeaONK62661_isOI@cipher.nrlssc.navy.mil>
References: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
Cc: gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 01:23:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJxHv-0005Rd-RL
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 01:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758925Ab0FBXXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 19:23:42 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36390 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758254Ab0FBXXk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 19:23:40 -0400
Received: by mail.nrlssc.navy.mil id o52NNY5C028506; Wed, 2 Jun 2010 18:23:34 -0500
In-Reply-To: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
X-OriginalArrivalTime: 02 Jun 2010 23:23:34.0186 (UTC) FILETIME=[9EC900A0:01CB02AA]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148277>

On 06/02/2010 01:21 AM, Sverre Rabbelier wrote:
> Heya,
> 
> On Wed, Jun 2, 2010 at 02:13, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> This test script depends on the git-remote-testgit python script.  This
>> python script makes use of the hashlib module which was released in python
>> version 2.5.  So, add a new pre-requisite named PYTHON_2_5_OR_NEWER to
>> test-lib.sh and check for it in t5800.
> 
> Perhaps instead we can change git-remote-testgit to do:
> 
> "try:
> import hashlib
> except ImportError:
> import ?? as hashlib
> "

Here's a work-around for the test suite until we figure out
what ?? should be.

[PATCH 1/2] Makefile: add PYTHON_PATH to GIT-BUILD-OPTIONS
[PATCH 2/2] t/t5800: skip if python version is older than 2.5
