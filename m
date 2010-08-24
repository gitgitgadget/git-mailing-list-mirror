From: Eric Raible <raible@gmail.com>
Subject: Re: [PATCH 2/1] do not pass &quot;git -c foo=bar&quot; params to transport helpers
Date: Tue, 24 Aug 2010 19:07:30 +0000 (UTC)
Message-ID: <loom.20100824T210316-895@post.gmane.org>
References: <7viq3119yn.fsf@alter.siamese.dyndns.org> <20100823183857.GA22386@coredump.intra.peff.net> <20100823191600.GA2523@coredump.intra.peff.net> <20100824064114.GA20724@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 21:07:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnyqY-000082-U3
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 21:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab0HXTHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 15:07:41 -0400
Received: from lo.gmane.org ([80.91.229.12]:51956 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138Ab0HXTHj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 15:07:39 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OnyqQ-0008S3-Fx
	for git@vger.kernel.org; Tue, 24 Aug 2010 21:07:38 +0200
Received: from mail.nextest.com ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 21:07:38 +0200
Received: from raible by mail.nextest.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 21:07:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.126 Safari/533.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154339>

Jonathan Nieder <jrnieder <at> gmail.com> writes:

>  #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
>  #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
>  #define CONFIG_ENVIRONMENT "GIT_CONFIG"
> +#define CONFIG_DATA_ENVIRONMENT "GIT_CONFIG_PARAMETERS"
>  #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
>  #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
>  #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"

Given that the pattern is:
#define foo_ENVIRONMENT "GIT_foo"

Your addition should be:
#define CONFIG_PARAMETERS_ENVIRONMENT "GIT_CONFIG_PARAMETERS"

Not only that, but the first one should be:

#define GRAFT_FILE_ENVIRONMENT "GIT_GRAFT_FILE"
