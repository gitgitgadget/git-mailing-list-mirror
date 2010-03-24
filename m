From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Question about .git/objects/info/alternates
Date: Wed, 24 Mar 2010 13:37:47 -0700
Message-ID: <a038bef51003241337p61705a35kd5ab6943bb27de36@mail.gmail.com>
References: <a038bef51003221026i379ee16ej6e0e6defcf0048dd@mail.gmail.com>
	 <20100323024223.GA12257@progeny.tock>
	 <a038bef51003241153g33445607qb3ab750e08b0584@mail.gmail.com>
	 <780e0a6b1003241316i4bbd4489w63ba0308706e4d20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, GIT <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 21:37:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuXKs-0000Wp-V5
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513Ab0CXUhu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 16:37:50 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:20277 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295Ab0CXUht convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 16:37:49 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2011155qwh.37
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bHB2QfDdLuWFH2IeNSrIHQPJuw0Ay0yMNLxAdPqfqKM=;
        b=gH22BD6hAmWu2vUsDNM8JmuT9redYYpMLmZdznzzSXXF5HFPi5jzC6x/cCjRGt3J4W
         /u8W5e8408w0m7ehTiXts/chMD8s5Ur4adrV/2AlNU6fyE6Tla+rnkOgOdpwtCw1SmTc
         u3rVAqhLAe/6REf6CF2CZOaWF5C4jnOd50a+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w85jV9CafifgQi0w4A3L7VyXT4T59RY/zLITerfCmxn4NG1gemf4zj8bFV2eZN/Svj
         k9vsXHOEFYPtiOvTHmtT8Gp2adO5hW9Ly7z4i6dh9xw31JXc/CjcHnlmNCYfucJiecgd
         e/MEq+j13SEqxRZSBMH6P/acLmWgNrAM54TZc=
Received: by 10.229.130.206 with SMTP id u14mr2538308qcs.74.1269463067684; 
	Wed, 24 Mar 2010 13:37:47 -0700 (PDT)
In-Reply-To: <780e0a6b1003241316i4bbd4489w63ba0308706e4d20@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143124>

On Wed, Mar 24, 2010 at 1:16 PM, Stephen Boyd <bebarino@gmail.com> wrot=
e:
> On Wed, Mar 24, 2010 at 11:53 AM, Chris Packham <judge.packham@gmail.=
com> wrote:
>>
>> +USAGE=3D'[-r|--recursive] [-a|--add <dir>] [-f|--force -d|--delete =
<dir>]'
> [...]
>> +case $oper in
>> + =C2=A0 =C2=A0add) add_alternate ;;
>> + =C2=A0 =C2=A0del) del_alternate ;;
>> + =C2=A0 =C2=A0*) =C2=A0 show_alternates ;;
>> +esac
>
> From a very high-level this should probably be more like git remote
> and git notes. 'add' and 'delete' would be subcommands instead of
> options. Plus you might have an explicit subcommand for show (or
> list?). Something like
>
> git alternates [show] =C2=A0[-r|--recursive]
> git alternates add <dir>
> git alternates delete =C2=A0[-f|--force] <dir>
>

I like that suggestion. I'd have to figure out the option parsing but
should be doable. This is of course assuming it remains its own
command set and isn't rolled into something else.
