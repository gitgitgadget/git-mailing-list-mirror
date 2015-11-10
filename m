From: Jeremy Morton <admin@game-point.net>
Subject: Allow git alias to override existing Git commands
Date: Tue, 10 Nov 2015 16:31:21 +0000
Message-ID: <56421BD9.5060501@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 17:39:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwBx8-0008IC-PO
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 17:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbbKJQjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 11:39:22 -0500
Received: from mail.gooeysoftware.com ([208.100.15.213]:46873 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbbKJQjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 11:39:20 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Nov 2015 11:39:20 EST
Received: from [192.168.1.3] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id 8849F18A00F2
	for <git@vger.kernel.org>; Tue, 10 Nov 2015 10:27:56 -0600 (CST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281124>

It's recently come to my attention that the "git alias" config 
functionality ignores all aliases that would override existing Git 
commands.  This seems like a bad idea to me.

For example, I wanted to setup "git clone" to automatically act as 
"git clone --recursive".  Sure I could do it in the shell, but it's 
more of a pain - any tutorial I set up about doing it would have to 
worry about what shell the user was using - and if you're going to 
make that argument, why have "git alias" at all?  It can all be done 
from the shell.

Obviously I could also use a different alias that wasn't an existing 
Git command for this behaviour, but that would rather defeat the 
point: I want "git clone" to have different functionality.  If I 
remembered to use a different Git command, I might as well remember to 
type "git clone --recursive".  Also, if a future Git command were 
introduced with the same name as my alias, my alias's functionality 
would suddenly be ignored, giving unexpected behaviour.

The reasoning behind this that it's "to avoid confusion and troubles 
with script usage" seems to be at odds with the general Git mentality 
that the user is given lots of power, and if they screw it up it's 
basically just user error.  For example, Git doesn't *have* to allow 
you to rebase.  It's a potentially dangerous operation, so why is it 
allowed?  It might "cause confusion and troubles".

On the other hand, by disallowing the overriding of existing Git 
commands through aliases you are preventing a lot of useful 
functionality that those aliases might be used for.

So I think you should either allow Git aliases to override existing 
Git commands by default, or at least provide a config option that 
allows the user to say that this should happen.

-- 
Best regards,
Jeremy Morton (Jez)
