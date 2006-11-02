X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Allow deletion of several patches at once
Date: Thu, 2 Nov 2006 10:36:51 +0000
Message-ID: <b0943d9e0611020236p60859a97ide18b95a2e069b1b@mail.gmail.com>
References: <20061023123714.GB10872@diana.vm.bytemark.co.uk>
	 <20061101090714.2066.93948.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 2 Nov 2006 10:37:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PBLIsROytNIEm9oUZ9U/ozzi01Xi0fKAUMttWP4bTICa0YgS2QdEwImj8JvssXmWL9iDQQS7Qx+RNl1bldnvM9tFyE4szaNnmDj5GgzAHZEmEhWTIpPdYxrDOXkAB9qdl5sEd+CuztsMDTXFd9VMaHNuO7yqQTML3NIi3LfT/nk=
In-Reply-To: <20061101090714.2066.93948.stgit@localhost>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30705>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfZwN-0004Yq-Ok for gcvg-git@gmane.org; Thu, 02 Nov
 2006 11:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752811AbWKBKgw convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 05:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbWKBKgw
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 05:36:52 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:38881 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1752811AbWKBKgw
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 05:36:52 -0500
Received: by py-out-1112.google.com with SMTP id a73so76814pye for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 02:36:51 -0800 (PST)
Received: by 10.35.114.16 with SMTP id r16mr586765pym.1162463811454; Thu, 02
 Nov 2006 02:36:51 -0800 (PST)
Received: by 10.35.77.5 with HTTP; Thu, 2 Nov 2006 02:36:51 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 01/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> This is an updated patch, which uses parse_patches() to support patch
> ranges. It replaces patch 2/2 in the series; patch 1/2 (original
> delete regression test) is unaffected.

I applied it but added another commit to change the algorithm
slightly. It now first checks whether the applied patches can be
deleted before deleting any patch (I find this safer). It also checks
for local changes, conflicts and HEAD =3D=3D top only if you delete
applied patches on the current branch. Actually, the HEAD =3D=3D top te=
st
failed when deleting on a different branch, which is normal since the
top is that of the other branch.

I'll make the changes public tonight.

Thanks.

--=20
