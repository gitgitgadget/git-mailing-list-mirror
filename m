From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: post-receive-email hook with custom_showrev
Date: Wed, 27 Feb 2013 08:42:14 +0100
Message-ID: <512DB8D6.9010109@alum.mit.edu>
References: <CA+mfgz1jrSbbZc7+asxfZivemYSvbB3+UxYx4sm3BwLmR0ELEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 08:42:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAbf3-0001Dp-Li
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 08:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab3B0HmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 02:42:21 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:44071 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752348Ab3B0HmU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2013 02:42:20 -0500
X-AuditID: 1207440f-b7f956d000001880-e9-512db8dbc951
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 99.3F.06272.BD8BD215; Wed, 27 Feb 2013 02:42:19 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r1R7gGLJ021005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Feb 2013 02:42:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <CA+mfgz1jrSbbZc7+asxfZivemYSvbB3+UxYx4sm3BwLmR0ELEA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqHt7h26gwfvzQhZdV7qZLG7PbGdz
	YPLYOesuu8fnTXIBTFHcNkmJJWXBmel5+nYJ3Blbfm9mLdjFU/F52gSWBsaHnF2MnBwSAiYS
	T9Z3sULYYhIX7q1n62Lk4hASuMwosXz5XlYI5ziTxO9Pk9lAqngFtCUe35vF3sXIwcEioCpx
	baYGSJhNQFdiUU8zE4gtKhAm0fv6HCNEuaDEyZlPWEBsEQEViQktv9hAWpkFxCX6/4GFhQUs
	JFYtmAHWKiQQIDFx3xuwVk6BQIlV3/+CxZkFdCTe9T1ghrDlJba/ncM8gVFgFpINs5CUzUJS
	toCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrolebmaJXmpK6SZGSJjy72DsWi9ziFGAg1GJ
	h3fxJZ1AIdbEsuLK3EOMkhxMSqK8J7bqBgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4f14AKic
	NyWxsiq1KB8mJc3BoiTOq75E3U9IID2xJDU7NbUgtQgmK8PBoSTBqwSMRyHBotT01Iq0zJwS
	hDQTByfIcC4pkeLUvJTUosTSkox4UJzGFwMjFSTFA7TXC6Sdt7ggMRcoCtF6ilGXY/e7Ry8Y
	hVjy8vNSpcR5pUGKBECKMkrz4FbAktIrRnGgj4V5NUGqeIAJDW7SK6AlTEBLEq+CPFdckoiQ
	kmpg3NrmrSvaZK7+RmVi1sW3oQ68l91u+H/s6ani+WQkeLpI/9XTq68XHD/+9PBNTofnb1W2
	y4ebZf5t/lan/3uN5k9/nb/vBHJXO1hwHM3VeOgz1f+QcP2l80unLjxVHMay+seW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217196>

On 02/22/2013 09:57 PM, Adam Mercer wrote:
> I'm trying to setup the post-receive-email hook, from contrib, using a
> custom_showrev, from the script I do this by setting hooks.showrev
> 
> # hooks.showrev
> #   The shell command used to format each revision in the email, with
> #   "%s" replaced with the commit id.  Defaults to "git rev-list -1
> #   --pretty %s", displaying the commit id, author, date and log
> #   message.  To list full patches separated by a blank line, you
> #   could set this to "git show -C %s; echo".
> #   To list a gitweb/cgit URL *and* a full patch for each change set, use this:
> #     "t=%s; printf 'http://.../?id=%%s' \$t; echo;echo; git show -C \$t; echo"
> #   Be careful if "..." contains things that will be expanded by shell "eval"
> #   or printf.
> 
> in my repositories config I have showrev set to:
> 
> [hooks]
>         showrev = t=%s; printf
> 'http://server/cgit/repository/commit/?id=%%s' \$t; echo;echo; git
> show -C \$t; echo

If I type that into my .git/config file then type "git config
hooks.showrev" I get "bad config file line 7 in .git/config" due to the
"\$".  I think the quoting in the comment in post-receive-email is
written as if it would be passed via the command line to "git config"; i.e.,

    git config hooks.showrev "t=%s; printf 'http://.../?id=%%s' \$t;
echo;echo; git show -C \$t; echo"

Granted, the docs don't make that clear.  See git-config(1) for the
details of the config file syntax.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
