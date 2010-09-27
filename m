From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 07/12] gitweb: remotes view for a single remote
Date: Mon, 27 Sep 2010 09:53:52 +0200
Message-ID: <201009270953.52562.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <201009262255.45959.jnareb@gmail.com> <AANLkTimemfDPdMycasFmqUvk0eF-eD9z7P1RFnitLD9G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 09:54:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P08XL-0006L1-00
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 09:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab0I0HyF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 03:54:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36542 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab0I0HyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 03:54:03 -0400
Received: by fxm3 with SMTP id 3so1626789fxm.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=41Vp5i0PUCrDGNXMShwEt2ZEJbyY29TLGPlfR4aS83A=;
        b=Dg02Y3Qv0pXmPDZs45QMQdMn1dEGxKSSBjU4eMaJl+NQufwhYJ+bRwTKH32JfZTD/B
         U5A1G1YoA3GSece9sfezhqNvfxBe+onNddBii6eqIyCpq1K2P7ATDn+HgQzke06mnjYt
         /yet1PkPymIG93/H6/ZO7ZkEYepF3yaqTHiSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EhIqSpx7RjjC2n2Yb86g9/Q8SzQCZth1YOtVx+i74QG7dc8ogdZNX5or4i2WZcC4iH
         EL9LEWX5vwHvotw3UiN/D5WoY2W0/oF1mGj2uMchyYj7qMHHnnmTbelgO/NNc9I5fK/D
         BE36bYkkMOMZQfFYfCRNZzsvszumJT3bP3H1w=
Received: by 10.223.118.73 with SMTP id u9mr7128168faq.36.1285574041756;
        Mon, 27 Sep 2010 00:54:01 -0700 (PDT)
Received: from [192.168.1.13] (abvz242.neoplus.adsl.tpnet.pl [83.8.223.242])
        by mx.google.com with ESMTPS id c20sm2242779fak.9.2010.09.27.00.53.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 00:54:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimemfDPdMycasFmqUvk0eF-eD9z7P1RFnitLD9G@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157317>

On Mon, 27 Sep 2010, Giuseppe Bilotta wrote:
> 2010/9/26 Jakub Narebski <jnareb@gmail.com>:
>> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

>>> +
>>> + =A0 =A0 git_header_html(undef, undef, 'header_extra' =3D> $remote=
);
>>
>> I don't quite like the name of this parameter, and I am not sure
>> if I like the API either.

Explanation: what I don't like (a tiny bit) about API is the need for
those 'undef, undef'... but this might be unavoidable, at least without
heavy hackery for little gain, because of the way Perl passes arguments
to subroutines.  (And no, rewrite of gitweb in Perl 6 is not a viable
solution ;-))

> As I mentioned in my replies to the other respective patches, I think
> it makes sense to make "all remotes" view easily accessible from the
> "single remote" view, and there are two ways I can think of: one is
> the "extra header text" way, by making the action name before it poin=
t
> to "all remotes". The other is to enable 'remotes' in the page nav
> submenu when we are in single remotes view (which is why I had the
> $current in format_ref_views instead of $action, and which is what is
> done by this change).  IMO it makes sense to have both ways available=
,
> but I'm open to suggestions about different approaches.

Now I understand it, and I completly agree that it is a very good
solution.  But it needs better description in the commit message.

Sidenote: http://git.oblomov.eu/rbot/remotes/anonj2 looks like doesn't
have this patch.  In the navigation bar it has

  _projects_ / _rbot_ / remotes

and not

  _projects_ / _rbot_ / _remotes_ / anonj2

>>> -     git_print_page_nav('','', $head,undef,$head,format_ref_views(=
'remotes'));
[...]
>>> +     git_print_page_nav('', '',  $head, undef, $head,

Why not

    +     git_print_page_nav('','', $head,undef,$head,

>>> +             format_ref_views($remote ? '' : 'remotes'));
>>
>> Why this change?

I might be not clear, but I meant here the change in formatting of call
to git_print_page_nav... and what I have not noticed is the fact that
format_ref_views is passed diferent argument.

And I see now here why passing action-like parameter ($current) to
format_ref_views allow for this.  I withdraw then proposal for using
$action global variable in place of $current argument; this API is
better (though perhaps this could be described in commit message)..
=20
--=20
Jakub Narebski
Poland
