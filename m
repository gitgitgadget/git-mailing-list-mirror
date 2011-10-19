From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Wed, 19 Oct 2011 17:09:31 -0500
Message-ID: <20111019220931.GA8322@elie.hsd1.il.comcast.net>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 00:09:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGeKc-0001hM-WF
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 00:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab1JSWJo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Oct 2011 18:09:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45523 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143Ab1JSWJn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2011 18:09:43 -0400
Received: by gyb13 with SMTP id 13so2130878gyb.19
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 15:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NTql7e/Swg7qCE0xIVx5hri6COC21Yqr8YSVqPYtoFE=;
        b=uJN8uJSe5mk25rq+geq8guXIN9CfDy8fqujuwUhcVYfwTbGlKVsN8dk09h448aD3Hy
         2xXJrGijrGgAharmFQCE5IwGQWFkAFzzeLcyQbo5ZngeF8ZXxg3cyt/tmQaA3hIQxvT/
         IgSHEf3BvRibxAoCWITh2cJLDTObaHcJECqGM=
Received: by 10.236.154.193 with SMTP id h41mr12500517yhk.15.1319062182995;
        Wed, 19 Oct 2011 15:09:42 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id u66sm10659243yhu.13.2011.10.19.15.09.41
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Oct 2011 15:09:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183987>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Someone asked me if having a "lulz" header wouldn't
> break things, but since we introduced the "encoding" header a while
> back clients have learned to ignore unknown headers, so it doesn't.
>
> Which is why we can discuss e.g. adding GPG headers without worrying
> about breaking everything.

Just for the record (and I think you understood this already): it is
not quite so simple.  Clients are allowed to assume that no "unknown"
header lines will appear before any of the known fields.  A future git
version could even assume that, say, a

	length-of-remainder-of-header

field appears before any lines after encoding and the GPG stuff.

So it would definitely be frowned upon to add new lines to that part
of the commit object without at least discussing it on this list.
Jeff mentioned one way to get your lulz without violating that
constraint. ;-)

http://thread.gmane.org/gmane.comp.version-control.git/138848/focus=3D1=
38921
