From: Azat Khuzhin <a3at.mail@gmail.com>
Subject: git-multimail: migration: Config is not iterable
Date: Thu, 29 May 2014 18:22:08 +0400
Message-ID: <20140529142208.GB27005@azat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu May 29 16:22:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq1Ds-0002Zg-Sd
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 16:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860AbaE2OWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 10:22:16 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:48461 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757503AbaE2OWN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 10:22:13 -0400
Received: by mail-la0-f53.google.com with SMTP id ty20so227888lab.26
        for <git@vger.kernel.org>; Thu, 29 May 2014 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=+MQ0NK4amG11VqOUf9HgN0W8DdNWODOpAHy20jkYxT4=;
        b=1CHoaQQtk0Isc9618dXA6D8xgnYMuqiduPou1xUBCXAICAxYgPVpn0zc7oVjgRIUw6
         5Boc6VmmWlNkdGSvYDzKITYZNiM/+LuuuByrb7lv/1VMr7SZHf2u4YilIiB8a38Cbmx4
         at5IBtjjDXIZQQ1I6wJzHRFZZTeksomZRyikUy1y7RHQUcxWgf92VlRIGka2O7nfSzkA
         YeFF7IG6S1zT6wWioWM0y05NH9sVWXPLP5Ocj5Plc6gapNCVQoNr/toR7kBHWMpW2MD2
         OyIZYkrhdBJfqTMnL4NPfyg45I0TpIory6tY5mHDY5LnpmkiOj1JR7sZLI/dZ21bhcRK
         ZfLA==
X-Received: by 10.112.13.137 with SMTP id h9mr5995261lbc.33.1401373330991;
        Thu, 29 May 2014 07:22:10 -0700 (PDT)
Received: from localhost ([188.134.22.24])
        by mx.google.com with ESMTPSA id q8sm767856lbr.28.2014.05.29.07.22.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 May 2014 07:22:10 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250372>

Hi there,

Using the latest version of git-multimail there is an issue with
migration:

$ ~azat/git-multimail/git-multimail/migrate-mailhook-config --overwrite
Traceback (most recent call last):
  File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 271, in <module>
    main(sys.argv[1:])
  File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 268, in main
    migrate_config(strict=options.strict, retain=options.retain, overwrite=options.overwrite)
  File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 159, in migrate_config
    if not _check_old_config_exists(old):
  File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 66, in _check_old_config_exists
    if name in old:
TypeError: argument of type 'Config' is not iterable

Tested on 2.6 and 2.7 python versions.

If you revert 09d0d5b92203f019763e43cef1e57f76f117d2b4 ("Get Python files to
pass pep8's tests.") there issue goes away. I understand that this is not the
right solution and I'm not the guru of python, so just let you know.

Thanks
