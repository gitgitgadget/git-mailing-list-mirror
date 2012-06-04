From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv5 4/4] Write to $XDG_CONFIG_HOME/git/config file
Date: Mon, 04 Jun 2012 23:17:58 +0200
Message-ID: <vpq4nqqn5dl.fsf@bauges.imag.fr>
References: <1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1338754481-27012-4-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin DUPERRAY <Valentin.DUPERRAY@ensimag.imag.fr>,
	Franck JONAS <Franck.JONAS@ensimag.imag.fr>,
	Thomas NGUY <Thomas.NGUY@ensimag.imag.fr>,
	Lucien KONG <Lucien.KONG@ensimag.imag.fr>
To: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 23:18:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbefF-0004WC-OU
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 23:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab2FDVSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 17:18:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37781 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753316Ab2FDVSH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 17:18:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q54L9QT0029929
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 23:09:26 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sbef1-0001DA-Tg; Mon, 04 Jun 2012 23:17:59 +0200
In-Reply-To: <1338754481-27012-4-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	(Huynh Khoi Nguyen NGUYEN's message of "Sun, 3 Jun 2012 22:14:41
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Jun 2012 23:09:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54L9QT0029929
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339448971.14757@Y4BTDd6oC9qhGvhPkjztAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199190>

Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
writes:

> +test_expect_success 'write: xdg file exists and ~/.gitconfig doesn'\''t' '
> +	mkdir -p .config/git &&
> +	>.config/git/config &&
> +	rm .gitconfig &&
> +	git config --global user.name "write_config" &&
> +	echo "[user]" >expected &&
> +	echo "	name = write_config" >>expected &&
> +	test_cmp expected .config/git/config
> +'

It was suggested that you also write to the XDG file if the XDG
_directory_ exists. After thinking about it, I tend to disagree with
this, because creating ~/.config/git/ignore would let Git write to the
XDG configuration file as a side effect, which I find strange.

Anyway, you may add the case where ~/.config/git/ exists but not the
config file in it to your tests, to materialize the decision you have
taken on that point.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
