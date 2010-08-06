From: Chris Packham <judge.packham@gmail.com>
Subject: getting an interpreted remote url for script use
Date: Fri, 06 Aug 2010 10:19:40 -0700
Message-ID: <4C5C442C.9080201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 19:19:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhQaG-0000km-06
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 19:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761605Ab0HFRTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 13:19:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33671 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab0HFRTp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 13:19:45 -0400
Received: by pvg2 with SMTP id 2so68236pvg.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=EKxpwys5HgWCmVwdY6CUSxXZPbFRe9KY7wBTgU8CRT4=;
        b=oynOvMLVAckvMGW92Weug5Tj0gzTU8eaBsWVjHL5hu9A4mHkKeW28t/+HIMXsW4hhC
         4kic0qR7VKNzAlHEV8VadTXilQ7JoxBLhGQNMTQ9wGPPeKCegpgxaJlMSS/9cD181JL6
         K0Y9cmEDZZp6BKQ1VMfIrKc3JfGKgTtASZ1N0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=Ws8k6jL3gXaW95IOIqe5OGlsREOslD5+1U6JF+BXLeGrK8gaZCo3v/wpd/BMvki2xM
         ewCkekDtqE/+/NjLzJfI9M+VCyD0GMvx6q5teUzZ6VySTQFsSz1Ig6OHEd6zC7wG8NgU
         BVjqeh0/JFdayjmbebK8p0+2zwugIVz3qx9ow=
Received: by 10.114.88.18 with SMTP id l18mr14368454wab.175.1281115184814;
        Fri, 06 Aug 2010 10:19:44 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id g4sm3197427wae.2.2010.08.06.10.19.43
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 10:19:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152797>

Hi,

I have a script that sends an email to a developer when someone applies
their patch (I know there are other server-side hooks that can be used
for this, but there are infrastructure reasons why these can't be used
easily).

Among other things my script tries to take the URL of the remote and
convert it to a http URL that is pointing to our internal server running
gitweb. The conversion is a simple s|ssh://|http://to-gitweb|

At the moment the script parses the output of 'git remote show origin'
to get the URL which was a bad idea to start with and has subsequently
been broken by changes in the show output (specifically the display of
Pull and Fetch URLs).

I think I should be doing is using 'git config remote.origin.url' to get
the URL but the problem with that is if someone has setup a URL alias
then I get the URL prior to the interpreting of that alias. Is there any
way for me to get the interpreted remote URL?

Thanks,
Chris
