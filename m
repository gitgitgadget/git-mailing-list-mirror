From: Steve <shrotty@gmx.ch>
Subject: Re: git-push on packed refs via HTTP
Date: Fri, 27 Mar 2009 10:20:36 +0000 (UTC)
Message-ID: <loom.20090327T102017-250@post.gmane.org>
References: <loom.20090320T094550-421@post.gmane.org> <be6fef0d0903200500u4d26d00fm653bc1e708a0c26b@mail.gmail.com> <loom.20090320T123018-838@post.gmane.org> <alpine.DEB.1.00.0903201341220.6865@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 11:22:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln9Cg-0000cS-Uk
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 11:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbZC0KUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 06:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbZC0KUv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 06:20:51 -0400
Received: from main.gmane.org ([80.91.229.2]:36811 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbZC0KUu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 06:20:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ln9B9-0008K1-QM
	for git@vger.kernel.org; Fri, 27 Mar 2009 10:20:48 +0000
Received: from 68.121.221.87.dynamic.jazztel.es ([87.221.121.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 10:20:47 +0000
Received: from shrotty by 68.121.221.87.dynamic.jazztel.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 10:20:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.221.121.68 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.7) Gecko/2009021906 Firefox/3.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114877>

Hi Dscho

Thanks for your snippet, that did the trick. I only had to alter it slightly
because the repo on the server is bare:

git show-ref |
while read sha1 name
do
  mkdir -p $(dirname $name) &&
  echo $sha1 > $name
done

Just for understanding: Why is this step necessary? Does it have anything to do
with serving the repo over HTTP at all?

Cheers, Steve
