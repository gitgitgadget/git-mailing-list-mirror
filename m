From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 4/7] web--browse: support opera, seamonkey and elinks
Date: Fri, 3 Dec 2010 23:22:08 +0100
Message-ID: <AANLkTi=DdQd5MgU2bp5sb5b5t1bzXpwf8WSJ=boSbc5q@mail.gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-5-git-send-email-giuseppe.bilotta@gmail.com> <7vei9yms6u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 23:22:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POe1V-0002w6-N5
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 23:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab0LCWWc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 17:22:32 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63808 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab0LCWWc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 17:22:32 -0500
Received: by iwn6 with SMTP id 6so383639iwn.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 14:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+QskE04Dc64L7r+/SviSkz1awytzDz9cDe9F7C4GasU=;
        b=uL8PWhj+YpopcrZcNLNnUxLsxnfB8JusPPBoWVQNzINJjAChZbKVAe8bi7Y9kB9ACT
         RtgGu55upGahWyOwjvltCaLS2jKOX6v6PIHpRtoMsHFnTRBZOX+VG90XznFnKEID9g/g
         bfJVW9Kpjz7SCp1NOboNGEZg/CGJXJgTBNpC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WDL4MEttijDE40kMNAZDdhzEBy8zxSbEDd1Kk1CIj9ia2lgV0AWLrjZRGTtSozFy2N
         QvEv8Qip6FyPWruBsWWvkp/xzatRYLf6YNE0M8B5DaoKJ4GW7lzGqyBN4FjztIg39OC5
         vzfy5PFmdGFbCBV82FbXUv3QSsN5F4WSpUPF4=
Received: by 10.231.12.131 with SMTP id x3mr2454930ibx.31.1291414951009; Fri,
 03 Dec 2010 14:22:31 -0800 (PST)
Received: by 10.231.39.3 with HTTP; Fri, 3 Dec 2010 14:22:08 -0800 (PST)
In-Reply-To: <7vei9yms6u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162869>

On Fri, Dec 3, 2010 at 11:01 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> -w3m|links|lynx|open)
>> +w3m|elinks|links|lynx|open)
>> =A0 =A0 =A0 eval "$browser_path" "$@"
>> =A0 =A0 =A0 ;;
>> =A0start)
>> =A0 =A0 =A0 exec "$browser_path" '"web-browse"' "$@"
>> =A0 =A0 =A0 ;;
>> -dillo)
>> +opera|dillo)
>> =A0 =A0 =A0 "$browser_path" "$@" &
>> =A0 =A0 =A0 ;;
>
> Not a complaint on your patch, but is there a reason we say "eval", "=
exec"
> and "(nothing)" in these three case arms?
>
> The above makes the interpretation of $browser_path and $@ inconsiste=
nt
> between lynx family codepath (which would apply $IFS to find the brow=
ser)
> and dillo and start family codepath (which would not), and I am wonde=
ring
> if that difference is intended.

I was wondering about this myself, but since I couldn't come up with
an explanation I opted for leaving things as they were. Lacking an
explanation I can also provide a patch to standardize invocation.

--=20
Giuseppe "Oblomov" Bilotta
