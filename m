From: Daniel Reichelt <debian@nachtgeist.net>
Subject: Re: gitweb: false base href sent when integrated via reverse proxy
 and path_info is active
Date: Sun, 28 Nov 2010 22:25:53 +0100
Message-ID: <4CF2C8E1.1050907@nachtgeist.net>
References: <20101128081048.13668.67286.reportbug@sb74.startrek> <201011281847.40233.jnareb@gmail.com> <4CF2BBEE.2050808@nachtgeist.net> <201011282207.03261.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Nov 28 22:26:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMokz-0007TS-KY
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 22:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab0K1VZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 16:25:56 -0500
Received: from srv04.jarevo.de ([88.198.54.146]:59876 "EHLO srv04.jarevo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab0K1VZz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 16:25:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by srv04.jarevo.de (Postfix) with ESMTP id E78AD4B6C;
	Sun, 28 Nov 2010 22:25:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv04.jarevo.de
Received: from srv04.jarevo.de ([127.0.0.1])
	by localhost (srv04.jarevo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PmeOBqudaTV3; Sun, 28 Nov 2010 22:25:53 +0100 (CET)
Received: from [10.0.0.1] (localhost [127.0.0.1])
	by srv04.jarevo.de (Postfix) with ESMTPA id 76AEF4B6B;
	Sun, 28 Nov 2010 22:25:53 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101030 Icedove/3.0.10
In-Reply-To: <201011282207.03261.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162362>

> The default name of gitweb config file is gitweb_config.perl, not
> gitweb.conf.  Are you sure you are picking correct config file?

Suppose this is Debian-specific:
************
our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
sub evaluate_gitweb_config {
        our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "gitweb_config.perl";
        our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} ||
"/etc/gitweb.conf";
        # die if there are errors parsing config file
        if (-e $GITWEB_CONFIG) {
                do $GITWEB_CONFIG;
                die $@ if $@;
        } elsif (-e $GITWEB_CONFIG_SYSTEM) {
                do $GITWEB_CONFIG_SYSTEM;
                die $@ if $@;
        }
}
************


> Try adding
>
>   our $site_name = "foo";
>
> to check if you are picking correct config file.

Yap, $site_name shows up in my browser's title.
