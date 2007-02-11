From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Possible BUG in 'git config'
Date: Sun, 11 Feb 2007 15:13:27 +0100
Message-ID: <e5bfff550702110613q315e1f7es4ca1a88b92e4c3e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 15:13:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGFSW-0002H7-G3
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 15:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbXBKONb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 09:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbXBKONb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 09:13:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:41035 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbXBKONa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 09:13:30 -0500
Received: by ug-out-1314.google.com with SMTP id 44so345303uga
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 06:13:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BWodcZPlW/L17EUAWUHizpx8yXNzgiS4FbDbfldYHjSrLDybN31QtTvQcdp6CDu0jip1b+z9Jmc3tb3WUfi8VMinicgF+DUp63slJx9vuCVQyBPiCyMKmTOGKqcVfjN8P405QcTtuV/QWVdZ1fpschbsv6CjvVY8H00mUT3eTQE=
Received: by 10.115.19.16 with SMTP id w16mr6549556wai.1171203207873;
        Sun, 11 Feb 2007 06:13:27 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sun, 11 Feb 2007 06:13:27 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39281>

bash-3.1$ cat ./.git/config
[i18n]
        commitencoding = UTF-8

bash-3.1$ git repo-config --global user.name
marco

bash-3.1$ git repo-config user.name
marco

I would expect git repo-config user.name returns an empty string,
because user.name is defined _only_ in global config file ~/.gitconfig

>From git-config documentation:

--global::
	Use global ~/.gitconfig file rather than the repository .git/config.



How it is possible to know if a variable is stored in local config file?

Thanks
Marco
