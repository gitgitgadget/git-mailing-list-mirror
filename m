From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Converting repo from HG, `git filter-branch --prune-empty --
 --all` is extremely slow and errors out.
Date: Fri, 13 Sep 2013 04:15:19 -0500
Message-ID: <CAMP44s0gHKTgw3xm6qRnvJk9S=p7ndMU6cwt3Ju38pBWbO_Syg@mail.gmail.com>
References: <D4C9DBA5F955904683C89B4A96DA7759EA78D60FDF@synapsemail>
	<CAMP44s1cmcfSuB-TnFL+-57i5W=EA8v322rVDoUELCPF948jPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1133f3d02624ff04e6404b96
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Gietzen <jgietzen@woot.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 11:15:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKPTK-0002ZD-3N
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 11:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab3IMJPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 05:15:22 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:41610 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769Ab3IMJPV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 05:15:21 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so1854004lbh.37
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 02:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Sk9wdEox2snPVB5lccrMIr0qpnk9cb++O/vQq1Ctpqk=;
        b=Z91TfhuYFxIzzo8IzgykvQ/j384ToBihMo23bB9xo8x5anDtusyTjV/p/Ql6VWeHnG
         uM36juq7agYdFfhxhvbcH2Zy0lnIQEpAQa5xgZFfquZ4jgS3AgluHqXJX3ORST0IVOlf
         DKmlQLJWI6lwYqW2KyL9n5IvWflygQNkICAGpTr89csj9utXfYFG7LHbnEtkk9Wunz0h
         /R3lu3jGSmZ+UeGjd6tn/IIdo3jii6gT7iYPYcjEmDv/cmI3WNDWaSJefL+QU1pOiAEj
         zp87UNOhws4e8LvUHofPsupb3jMlEyeEMUAPsSGu0lRIjCVz2jvAVzcSkiHmiZTR3VDL
         mCbQ==
X-Received: by 10.152.228.130 with SMTP id si2mr821508lac.32.1379063719923;
 Fri, 13 Sep 2013 02:15:19 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 13 Sep 2013 02:15:19 -0700 (PDT)
In-Reply-To: <CAMP44s1cmcfSuB-TnFL+-57i5W=EA8v322rVDoUELCPF948jPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234738>

--001a1133f3d02624ff04e6404b96
Content-Type: text/plain; charset=UTF-8

On Thu, Sep 12, 2013 at 7:47 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> Indeed, I remember writing my own simplified version of 'git
> filter-branch' that was much faster. If I recall correctly, the trick
> was avoiding 'git write-tree' which can be done if you are not using
> any tree filter, but 'git filter-branch' is not that smart.
>
> If all you want to do is prune empty commits, it should be easy to
> write a script that simply does 'git commit-tree'. I might decide to
> do that based on my script if I have time today.

Here it is, it's straightforward and should be easy to understand.

-- 
Felipe Contreras

--001a1133f3d02624ff04e6404b96
Content-Type: application/octet-stream; name=filter-branch
Content-Disposition: attachment; filename=filter-branch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hlj6qr4l0

IyEvdXNyL2Jpbi9lbnYgcnVieQoKcmVxdWlyZSAnZGF0ZScKCmNsYXNzIENvbW1pdAoKICBhdHRy
X3JlYWRlciA6aWQsIDpwYXJlbnRzLCA6bXNnCgogIGRlZiBpbml0aWFsaXplKGRhdGEpCiAgICBA
cGFyZW50cyA9IFtdCiAgICBtc2cgPSBuaWwKCiAgICBkYXRhLmVhY2hfbGluZSBkbyB8bHwKICAg
ICAgbC5lbmNvZGUhKCd1dGYtOCcsICdpc28tODg1OS0xJykgaWYgbm90IGwudmFsaWRfZW5jb2Rp
bmc/CgogICAgICBpZiBub3QgbXNnCiAgICAgICAgY2FzZSBsCiAgICAgICAgd2hlbiAvXmNvbW1p
dCAoLispJC8KICAgICAgICAgIEBpZCA9ICQxCiAgICAgICAgd2hlbiAvXnRyZWUgKC4rKSQvCiAg
ICAgICAgICBAdHJlZSA9ICQxCiAgICAgICAgd2hlbiAvXmF1dGhvciAoLispIDwoLispPiAoLisp
JC8KICAgICAgICAgIEBhdXRob3IgPSBbJDEsICQyXQogICAgICAgICAgQGF1dGhvcl9kYXRlID0g
RGF0ZVRpbWUuc3RycHRpbWUoJDMsICclcyAleicpCiAgICAgICAgd2hlbiAvXmNvbW1pdHRlciAo
LispIDwoLispPiAoLispJC8KICAgICAgICAgIEBjb21taXR0ZXIgPSBbJDEsICQyXQogICAgICAg
ICAgQGNvbW1pdHRlcl9kYXRlID0gRGF0ZVRpbWUuc3RycHRpbWUoJDMsICclcyAleicpCiAgICAg
ICAgd2hlbiAvXnBhcmVudHMgKC4rKSQvCiAgICAgICAgICBAcGFyZW50cyA9ICQxLnNwbGl0KCIg
IikKICAgICAgICB3aGVuIC9eJC8KICAgICAgICAgIG1zZyA9ICIiCiAgICAgICAgZW5kCiAgICAg
IGVsc2UKICAgICAgICBtc2cgPDwgbAogICAgICBlbmQKICAgIGVuZAoKICAgIEBtc2cgPSBtc2cK
ICBlbmQKCiAgZGVmIGV4cG9ydCgpCiAgICBFTlZbJ0dJVF9BVVRIT1JfTkFNRSddID0gQGF1dGhv
clswXQogICAgRU5WWydHSVRfQVVUSE9SX0VNQUlMJ10gPSBAYXV0aG9yWzFdCiAgICBFTlZbJ0dJ
VF9BVVRIT1JfREFURSddID0gQGF1dGhvcl9kYXRlLnN0cmZ0aW1lKCclcyAleicpCiAgICBFTlZb
J0dJVF9DT01NSVRURVJfTkFNRSddID0gQGNvbW1pdHRlclswXQogICAgRU5WWydHSVRfQ09NTUlU
VEVSX0VNQUlMJ10gPSBAY29tbWl0dGVyWzFdCiAgICBFTlZbJ0dJVF9DT01NSVRURVJfREFURSdd
ID0gQGNvbW1pdHRlcl9kYXRlLnN0cmZ0aW1lKCclcyAleicpCgogICAgbmV3X2lkID0gbmlsCgog
ICAgIyBza2lwIGVtcHR5CiAgICBpZiBAcGFyZW50cy5zaXplID09IDEKICAgICAgb2xkX3RyZWUg
PSBgZ2l0IHJldi1wYXJzZSAje0BwYXJlbnRzLmZpcnN0fV57dHJlZX1gLmNob21wCiAgICAgIGlm
IG9sZF90cmVlID09IEB0cmVlCiAgICAgICAgJGNvbW1pdF9tYXBbQGlkXSA9IEBwYXJlbnRzLmZp
cnN0CiAgICAgICAgcmV0dXJuCiAgICAgIGVuZAogICAgZW5kCgogICAgcGFyZW50cyA9IEBwYXJl
bnRzLm1hcCB7IHxlfCBbJy1wJywgJGNvbW1pdF9tYXBbZV1dIH0uZmxhdHRlbgogICAgSU8ucG9w
ZW4oWydnaXQnLCAnY29tbWl0LXRyZWUnLCBAdHJlZV0gKyBwYXJlbnRzLCAidysiKSBkbyB8cGlw
ZXwKICAgICAgcGlwZS53cml0ZShAbXNnKQogICAgICBwaXBlLmNsb3NlX3dyaXRlCiAgICAgIG5l
d19pZCA9IHBpcGUucmVhZCgpLmNob21wKCkKICAgIGVuZAoKICAgICRjb21taXRfbWFwW0BpZF0g
PSBuZXdfaWQKICBlbmQKCmVuZAoKJGNvbW1pdF9tYXAgPSB7fQoKc3RhY2sgPSBbXQpoZWFkcyA9
IHt9CgpJTy5wb3Blbigld1tnaXQgZm9yLWVhY2gtcmVmIC0tZm9ybWF0PSUocmVmbmFtZSk6JShv
YmplY3RuYW1lKV0pLmVhY2ggZG8gfGx8CiAgcmVmLCBpZCA9IGwuY2hvbXAuc3BsaXQoJzonKQog
IGhlYWRzW3JlZl0gPSBpZAplbmQKCmZvcm1hdCA9IFsKICAnY29tbWl0ICVIJywKICAndHJlZSAl
VCcsCiAgJ2F1dGhvciAlYW4gPCVhZT4gJWFkJywKICAnY29tbWl0dGVyICVjbiA8JWNlPiAlY2Qn
LAogICdwYXJlbnRzICVQJywKICAnJywgJyVCJyBdLmpvaW4oJyVuJykKYXJncyA9ICV3Wy0tcmV2
ZXJzZSAtLXRvcG8tb3JkZXIgLS1wYXJlbnRzIC0tc2ltcGxpZnktbWVyZ2VzIC0tYWxsXQpjb21t
YW5kID0gJVdbZ2l0IGxvZyAteiAtcyAtLWRhdGU9cmF3IC0tZm9ybWF0PWZvcm1hdDoje2Zvcm1h
dH1dICsgYXJncwpJTy5wb3Blbihjb21tYW5kKS5lYWNoKCJcMCIpIGRvIHxkYXRhfAogIGMgPSBD
b21taXQubmV3KGRhdGEuY2hvbXAoIlwwIikpCiAgc3RhY2sgPDwgYwplbmQKCmRlZiBzaG93KHN0
cikKICAkc3Rkb3V0LnByaW50KHN0cikgaWYgJHN0ZG91dC5pc2F0dHkKZW5kCgpjb3VudCA9IDAK
dG90YWwgPSBzdGFjay5zaXplCgp1bnRpbCBzdGFjay5lbXB0eT8gZG8KICBjID0gc3RhY2suc2hp
ZnQKCiAgbmV4dCBpZiAkY29tbWl0X21hcFtjLmlkXQoKICBjLmV4cG9ydAogIHNob3cgIlxyUmV3
cml0ZSAje2MuaWR9ICgje2NvdW50ICs9IDF9LyN7dG90YWx9KSIKZW5kCgpzaG93ICJcbiIKCmhl
YWRzLmVhY2ggZG8gfHJlZiwgaWR8CiAgbmV3X2lkID0gJGNvbW1pdF9tYXBbaWRdCiAgbmV4dCBp
ZiBub3QgaWQgb3Igbm90IG5ld19pZCBvciBpZCA9PSBuZXdfaWQKICBzeXN0ZW0oJ2dpdCcsICd1
cGRhdGUtcmVmJywgcmVmLCBuZXdfaWQsIGlkKQogIHB1dHMgJyVzICVzIC0+ICVzJyAlIFtyZWYs
IGlkLCBuZXdfaWRdCmVuZAo=
--001a1133f3d02624ff04e6404b96--
