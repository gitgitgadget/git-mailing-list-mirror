From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v4] http: add support for specifying an SSL cipher list
Date: Fri,  8 May 2015 14:15:05 +0200
Message-ID: <1431087305-8988-1-git-send-email-szeder@ira.uka.de>
References: <1431056685-12337-1-git-send-email-lars@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Lars Kellogg-Stedman <lars@redhat.com>
X-From: git-owner@vger.kernel.org Fri May 08 14:16:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqhCE-0001MX-VJ
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 14:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbbEHMP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 08:15:58 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43014 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751118AbbEHMP6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2015 08:15:58 -0400
Received: from x590e3a3d.dyn.telefonica.de ([89.14.58.61] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1YqhC4-0004ps-5C; Fri, 08 May 2015 14:15:53 +0200
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1431056685-12337-1-git-send-email-lars@redhat.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1431087353.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268614>

> +http.sslCipherList::
> +  A list of SSL ciphers to use when negotiating an SSL connection.
> +  The available ciphers depend on whether libcurl was built against
> +  NSS or OpenSSL and the particular configuration of the crypto
> +  library in use.  Internally this sets the 'CURLOPT_SSL_CIPHER_LIST=
'
> +  option; see the libcurl documentation for more details on the form=
at
> +  of this list.
> ++
> +Can be overridden by the 'GIT_SSL_CIPHER_LIST' environment variable.
> +To force git to use libcurl's default cipher list and ignore any
> +explicit http.sslCipherList option, set 'GIT_SSL_CIPHER_LIST' to the
> +empty string.
> +

=2E.. or with 'git -c http.sslCipherList <cmd>' on the command line (bu=
t I
don't think it should be mentioned here that a config variable from a
config file can be overridden via 'git -c', because that's true for all
config variables anyway).

However, speaking of command line, could you please add this new config
variable to the completion script (contrib/completion/git-completion.ba=
sh,
somewhere around line 2120)?  Thanks.

Best,
G=E1bor
