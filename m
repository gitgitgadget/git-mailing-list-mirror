From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv5 4/4] Write to $XDG_CONFIG_HOME/git/config file
Date: Tue, 05 Jun 2012 15:04:32 +0200
Message-ID: <20120605150432.Horde.RXb5CHwdC4BPzgPgu1YiviA@webmail.minatec.grenoble-inp.fr>
References: <1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338754481-27012-4-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <vpq4nqqn5dl.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=";";
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin DUPERRAY <Valentin.DUPERRAY@ensimag.imag.fr>,
	Franck JONAS <Franck.JONAS@ensimag.imag.fr>,
	Thomas NGUY <Thomas.NGUY@ensimag.imag.fr>,
	Lucien KONG <Lucien.KONG@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 15:04:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbtRA-0004Kq-HD
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 15:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757716Ab2FENEg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 09:04:36 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:39352 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757210Ab2FENEf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 09:04:35 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 2AF311A0241;
	Tue,  5 Jun 2012 15:04:33 +0200 (CEST)
Received: from wifi-030246.grenet.fr (wifi-030246.grenet.fr
 [130.190.30.246]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Tue, 05 Jun 2012 15:04:32 +0200
In-Reply-To: <vpq4nqqn5dl.fsf@bauges.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199236>


Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=A9crit=C2=A0:

> Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
> writes:
>
>> +test_expect_success 'write: xdg file exists and ~/.gitconfig doesn'=
\''t' '
>> +	mkdir -p .config/git &&
>> +	>.config/git/config &&
>> +	rm .gitconfig &&
>> +	git config --global user.name "write_config" &&
>> +	echo "[user]" >expected &&
>> +	echo "	name =3D write_config" >>expected &&
>> +	test_cmp expected .config/git/config
>> +'
>
> It was suggested that you also write to the XDG file if the XDG
> _directory_ exists. After thinking about it, I tend to disagree with
> this, because creating ~/.config/git/ignore would let Git write to th=
e
> XDG configuration file as a side effect, which I find strange.
>
> Anyway, you may add the case where ~/.config/git/ exists but not the
> config file in it to your tests, to materialize the decision you have
> taken on that point.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

I agree. This case will be added in our next v6 version.
