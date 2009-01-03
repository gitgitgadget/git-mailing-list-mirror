From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] gitweb: merge boolean feature subroutines
Date: Sat, 3 Jan 2009 17:18:44 +0100
Message-ID: <9b18b3110901030818i242d81ccl20ef3f264ec64cad@mail.gmail.com>
References: <1230996692-7182-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matt Kraai" <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sat Jan 03 17:20:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ9EP-0002Uk-QK
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 17:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759164AbZACQSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 11:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759002AbZACQSr
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 11:18:47 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:34311 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758902AbZACQSq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 11:18:46 -0500
Received: by qw-out-2122.google.com with SMTP id 3so5783355qwe.37
        for <git@vger.kernel.org>; Sat, 03 Jan 2009 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/ImGBwfuRhp4aGMehDd4aFUdCAUsTioCXCqNe+dA0eA=;
        b=fJny3Ol9DH1iNrsNEfa15zTkZlN4s/64qr1I3+hKhZdoT5vEjzeY2ykl1azTSW5+wx
         smzwQQve7p5okeVHgp+EkMoUd/8a0W1RIhDoQtzg9RuqVsTlv64LonFVoMurp+++qz9o
         fPFs5OJZXd0gZ565CeO15nbT+dFOnHW++N+xU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=htvaTzVwehjYAYgd8r73aKRNYjLL+LODrqX1lU/VakiWfzka07+PMnklzUEU76yPoX
         jHy9ko//a4evrjgdOaGTk2ID7CuP/lQVHCLJr4T7OtH+d1Qnly0zKCw23QmfzTlZ6zU+
         9oA/ROUg+2UBiSU5YK6EBkK2sMrKmK7GyGKhA=
Received: by 10.214.115.21 with SMTP id n21mr15622261qac.211.1230999524876;
        Sat, 03 Jan 2009 08:18:44 -0800 (PST)
Received: by 10.214.241.2 with HTTP; Sat, 3 Jan 2009 08:18:44 -0800 (PST)
In-Reply-To: <1230996692-7182-1-git-send-email-kraai@ftbfs.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104471>

2009/1/3 Matt Kraai <kraai@ftbfs.org>:
[...]
> -sub feature_blame {
> -       my ($val) = git_get_project_config('blame', '--bool');
> +sub feature_bool {
> +       my $key = shift;
> +       my ($val) = git_get_project_config($key, '--bool');
>
>        if ($val eq 'true') {
>                return 1;

Maybe that should be:

           return ($val eq 'true');

as It is not a good idea to use 0 as a replacement for perls false, as
the two have different behaviour.

$perl -wle'my $val=shift; my $x=$val eq "true"; print "<$_>" for $x, 0+$x' false
<>
<0>

Cheers,
yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
