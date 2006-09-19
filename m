From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb: Require project for all actions except few
Date: Tue, 19 Sep 2006 15:21:15 +0200
Message-ID: <20060919132115.GA32645@moooo.ath.cx>
References: <200609191438.28685.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 15:21:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPfXP-0006s3-M7
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 15:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWISNVV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 09:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWISNVU
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 09:21:20 -0400
Received: from moooo.ath.cx ([85.116.203.178]:53941 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1030289AbWISNVU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 09:21:20 -0400
To: Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200609191438.28685.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27277>

Jakub Narebski <jnareb@gmail.com> wrote:
> +if ($action !~ m/^opml|project_list|project_index$/ &&
The regexp should be:
m/^(opml|project_list|project_index)$/ &&

% (echo opml_foo; echo foo_project_list_bar; echo bar_project_index) |
    perl -ne 'print if m/^opml|project_list|project_index$/;' 
opml_foo
foo_project_list_bar
bar_project_index
