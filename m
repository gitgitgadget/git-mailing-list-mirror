From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] git-p4: chdir now properly sets PWD environment variable
 in msysGit
Date: Mon, 04 Aug 2008 00:06:07 -0300
Message-ID: <g75ror$uav$1@ger.gmane.org>
References: <bad7471c0808011250v569ffaaby9e20a5ba1f971927@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 05:08:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPqQt-0000DI-VC
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 05:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbYHDDH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 23:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754231AbYHDDH0
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 23:07:26 -0400
Received: from main.gmane.org ([80.91.229.2]:55226 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892AbYHDDHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 23:07:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KPqPp-00013g-Df
	for git@vger.kernel.org; Mon, 04 Aug 2008 03:07:21 +0000
Received: from 201.80.3.52 ([201.80.3.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 03:07:21 +0000
Received: from hanwen by 201.80.3.52 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 03:07:21 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 201.80.3.52
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <bad7471c0808011250v569ffaaby9e20a5ba1f971927@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91309>

Robert Blum escreveu:
> P4 on Windows expects the PWD environment variable to be set to the
> current working dir, but os.chdir in python doesn't do that by default

> +if os.name == 'nt':
> +    def os_chdir(dir):
> +        os.environ['PWD']=dir
> +        os.chdir(dir)
> +else:
> +    os_chdir = os.chdir
> +

Stylistic:

I think the naming is a bit ugly (os_); I would write

  def chdir(d):
     if os.name == 'nt': .. 
     os.chdir(dir)

for the rest: looks good to me.
	
-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
