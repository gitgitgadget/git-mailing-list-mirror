From: Andrew Pimlott <andrew@pimlott.net>
Subject: --simplify-by-decoration, but include branch points
Date: Thu, 22 Sep 2011 11:24:34 -0700
Message-ID: <1316715489-sup-9523@pimlott.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 20:24:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6nwv-0003j2-49
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 20:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363Ab1IVSYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 14:24:36 -0400
Received: from pimlott.net ([72.249.23.100]:38458 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684Ab1IVSYf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 14:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:To:From:Subject:Content-Type; bh=o0l4kOYprX6cFlfeaLbun2qIOAX6l7skP0fdSw9YskU=;
	b=bkDcP8UPJwealAZFVxISe25l0IWoL0KamXNIj4kNfBm/Dz5dzeWKQ5pc3yEp+OJ11eQuHkSIRzya+vdNPZ5lLSVuJSpkxDSyNN1o4VsMV1WkPbjNKDh3qYcEEvn2wJ6BKMC6amig20d3jF9fGzEEcJli3j4ARtG5mtcRpeHVfn8=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1R6nwo-0005QA-8e
	for git@vger.kernel.org; Thu, 22 Sep 2011 11:24:35 -0700
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181909>

The --simplify-by-decoration option to git log is a great way to view
branch topology.  However, it is a bit misleading because it does not
necessarily show branch points.  For example, I have a repository that
looks like:

    * 6045d25 (HEAD, master) 3
    | * 8daa592 (branch) 2.1
    |/
    * a4da73a 2
    * 014106d (tag: v1) 1

This is from "git log --decorate --all --graph --oneline".  If I add
--simplify-by-decoration, I get

    * 6045d25 (HEAD, master) 3
    | * 8daa592 (branch) 2.1
    |/
    * 014106d (tag: v1) 1

Note it appears as though the branch point is 014106d, when it's really
014106d.  I would love to see an option like --simplify-by-decoration
that also selects branch points for display, maybe
--simplify-by-branch-point.  (It should be possible to combine it with
--simplify-by-decoration.)

Is there anything like this?

Andrew
