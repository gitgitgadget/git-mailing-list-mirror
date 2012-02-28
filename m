From: Jon Jagger <jon@jaggersoft.com>
Subject: Re: git (commit|tag) atomicity
Date: Tue, 28 Feb 2012 20:43:21 +0000
Message-ID: <CADWOt=iz91AjBbkrc6cJqSqadyP9nDqBg92j0qDwBmHxkSUqZg@mail.gmail.com>
References: <CADWOt=j8gJvr88eNAfoYq_qGQvG6M_k-9MCuof_DRrH0sHRVCA@mail.gmail.com>
	<4F4D04F4.80905@ira.uka.de>
	<CADWOt=ig5=Bhhkjs9-wbm2djtwWPOfPGtYt9pH-U3YuQ+iyXzg@mail.gmail.com>
	<m3aa42vosb.fsf@localhost.localdomain>
	<4F4D2391.9020701@zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 21:43:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2TtV-0004ry-9K
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 21:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415Ab2B1UnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 15:43:25 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:53566 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030404Ab2B1UnX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 15:43:23 -0500
Received: by wejx9 with SMTP id x9so1257269wej.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 12:43:22 -0800 (PST)
Received-SPF: pass (google.com: domain of jrbjagger@googlemail.com designates 10.180.101.37 as permitted sender) client-ip=10.180.101.37;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrbjagger@googlemail.com designates 10.180.101.37 as permitted sender) smtp.mail=jrbjagger@googlemail.com; dkim=pass header.i=jrbjagger@googlemail.com
Received: from mr.google.com ([10.180.101.37])
        by 10.180.101.37 with SMTP id fd5mr12909115wib.1.1330461802080 (num_hops = 1);
        Tue, 28 Feb 2012 12:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=6QzzcLngjGoJkd2cI4utcceQbR3jn2ul1mFnnB2ipS0=;
        b=lc7sULWM2zXRjsECTmlmktXMtMIT8E89KkMAu+5tqjOieaouaEf3a1IZYzp1XqlBO3
         QzHDF3sc1MY50caSkRGIUP15ZmAmzaP3Oh/Aap3FpiaSB/X9t1M6b2elVBn+826ih2nJ
         pM+1GOccLhiArfA1TqQD141mbjtK+uwvLrGto=
Received: by 10.180.101.37 with SMTP id fd5mr10247890wib.1.1330461802038; Tue,
 28 Feb 2012 12:43:22 -0800 (PST)
Received: by 10.216.121.14 with HTTP; Tue, 28 Feb 2012 12:43:21 -0800 (PST)
In-Reply-To: <4F4D2391.9020701@zabbo.net>
X-Google-Sender-Auth: 9Fb7jy6CZEeMDEbg5OtAv_boGXU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191783>

On Tue, Feb 28, 2012 at 6:57 PM, Zach Brown <zab@zabbo.net> wrote:
>
> It's a bit of a tangent, but just to be sure people don't get the wro=
ng
> impression..
>
>
>> But I am not sure... that probably depends on how opendir(3) and
>> readdir(3) works on given filesystem wrt. updates to opened director=
y.
>> I think VFS on Linux ensures that you see view of filesystem as it w=
as
>> on opendir().
>
>
> No, readdir() does not give you a static view of the entries in a
> directory as it was on opendir(). =A0readdir() will reflect modificat=
ions
> that are done after opendir(). =A0The specifics for a given situation
> depend on how the file system maps the readdir position (f_pos) to
> directory entries. =A0You can see very different results when compari=
ng,
> say, stock ext2, indexed ext[34], and btrfs.

Ok. Thanks.
