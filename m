From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCHv2 2/2] daemon: allow more than one host address given via --listen
Date: Sun, 29 Aug 2010 17:11:54 +0200
Message-ID: <AANLkTi==kDW7FbTZ7P6nF+k8_jGTJsFvwkcRijR=jex4@mail.gmail.com>
References: <7v4oel14tl.fsf@alter.siamese.dyndns.org> <1283094462-5184-3-git-send-email-alexander@sulfrian.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Alexander Sulfrian <alexander@sulfrian.net>
X-From: git-owner@vger.kernel.org Sun Aug 29 17:12:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpjYS-0001dG-5i
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 17:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab0H2PMP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 11:12:15 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50722 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab0H2PMP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 11:12:15 -0400
Received: by vws3 with SMTP id 3so4334472vws.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Q0QynMSaSjLCfakLnaR/VV6nBxx31u6ibS8Cjwg/2GE=;
        b=lCRJ5jmzd5jDWW/3pycXvu/7BnGpGvnXZ2SP7w2RXqhW9Cst2ZeN/vNRJLytDs7AzO
         TmKpUeSUOrVJHXA3XdB8HUbmQmYhJazG9ye2PzCNelvf3LVzX0yEfNvlnLO1VbPHHcCV
         lh6dLRX0s+by02ViIYVhPXdS7Sw3LReD++N0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=tZZTuejmyMNIV/3rZwqFjn2IfUQeivItNrTIAG7R1kV+qUSSvTHbb/nqKukNNpMSPL
         CCL2qtdZD6DQO6RChGPLoAXt8Bt56WOfbdty3cWnPHOiQomBCk+edYbCeDyfoXG1lHV7
         9OJCm2Yg0gYbvidGWI2nCXZ1RVcw7kTRXaYqQ=
Received: by 10.220.124.85 with SMTP id t21mr1872765vcr.5.1283094734191; Sun,
 29 Aug 2010 08:12:14 -0700 (PDT)
Received: by 10.220.180.76 with HTTP; Sun, 29 Aug 2010 08:11:54 -0700 (PDT)
In-Reply-To: <1283094462-5184-3-git-send-email-alexander@sulfrian.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154689>

On Sun, Aug 29, 2010 at 5:07 PM, Alexander Sulfrian
<alexander@sulfrian.net> wrote:
> @@ -987,6 +997,7 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0struct group *group;
> =A0 =A0 =A0 =A0gid_t gid =3D 0;
> =A0 =A0 =A0 =A0int i;
> + =A0 =A0 =A0 int return_value;
>
> =A0 =A0 =A0 =A0git_extract_argv0_path(argv[0]);
>
<snip>
> @@ -1174,5 +1185,7 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0if (pid_file)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0store_pid(pid_file);
>
> - =A0 =A0 =A0 return serve(listen_addr, listen_port, pass, gid);
> + =A0 =A0 =A0 return_value =3D serve(&listen_addr, listen_port, pass,=
 gid);
> +
> + =A0 =A0 =A0 return return_value;
> =A0}

Uhm, why? I can't find any other uses for "return_value"...
