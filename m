From: Marat Radchenko <marat@slonopotamus.org>
Subject: [BUG] 'pread' : macro redefinition
Date: Sun, 30 Mar 2014 13:44:21 +0000 (UTC)
Message-ID: <loom.20140330T154129-838@post.gmane.org>
References: <20140319213556.2FC3D4062B@wince.sfo.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:45:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUG34-0004RF-NM
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbaC3Nok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 09:44:40 -0400
Received: from plane.gmane.org ([80.91.229.3]:43986 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbaC3Noj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:44:39 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WUG2P-000409-2C
	for git@vger.kernel.org; Sun, 30 Mar 2014 15:44:37 +0200
Received: from core-gate-01-v50-x7.possvyaz.ru ([core-gate-01-v50-x7.possvyaz.ru])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 15:44:37 +0200
Received: from marat by core-gate-01-v50-x7.possvyaz.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 15:44:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 176.57.72.72 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.149 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245463>

Stefan Zager <szager <at> chromium.org> writes:

> 
> This adds a Windows implementation of pread.
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 08b83fe..377ba50 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> +ssize_t mingw_pread(int fd, void *buf, size_t count, off64_t offset);
> +#define pread mingw_pread

This result in tons of following warnings in MSVC=1 build:

git-compat-util.h(401) : warning C4005: 'pread' : macro redefinition
mingw.h(181) : see previous definition of 'pread'
