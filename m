Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10061F461
	for <e@80x24.org>; Tue, 27 Aug 2019 10:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfH0KFI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 06:05:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:58177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfH0KFI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 06:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566900297;
        bh=iAZnC8st0WqvyumrD3tKmmHI+wlwS8Bpgmza/OUMZ1I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CdE2tnJjnuemSyUn8E0gS8p/mY0/e/IMbuRBuil/Qt7Ad2RLFhFDjlSOmNBuO89Er
         KUwJSAsbdX0HMxif/UNbSSB792SlJR1tani30EtKDXk+SHG8gNHqzHXR4S7Z6FC0cV
         9KPDd7EMc8TA3iM47NrIyONEQ5I1HtELhBqlglCw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGoU1-1hxvmy2FbF-00DTQ6; Tue, 27
 Aug 2019 12:04:57 +0200
Date:   Tue, 27 Aug 2019 12:04:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Daniel Ferreira via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Daniel Ferreira <bnmvco@gmail.com>
Subject: Re: [PATCH v3 03/11] built-in add -i: implement the `status`
 command
In-Reply-To: <xmqqsgqmoyz1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1908271123570.46@tvgsbejvaqbjf.bet>
References: <pull.170.v2.git.gitgitgadget@gmail.com>        <pull.170.v3.git.gitgitgadget@gmail.com>        <b93b055ebeef98be11a1658453df6f85fed87347.1563289115.git.gitgitgadget@gmail.com> <xmqqsgqmoyz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+qzyIGVLOZCy81svUqAOFZxr1hzoH47A2eVAnyS0lnvjG9S/yi6
 U18/YVKox0cTMuAodLlX3U4fSuv1NIC6J+Sf4mqu13Q47BWwKxSBQXQYY+J8UFv7dHr+Jku
 rIBsuHYnUySF94M1e91OVbBxXPfKRcMjiZZ1Igd0a/Zor0+OExMD9bNguDFTwzVW+Fe60en
 FNHDUkfaFjfI+/QchbsiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YaoCQeT6C/I=:BbgfdeBjj3OsXT3roIgFte
 c5k01WvD2A+MPaHbkY4VMOAuw3cAx49Ri2cRu876kJQMMT7OtMQbOAr6Ow6vxSlR4hS09nymI
 Rtkpp01c2u+N3g7TtQMzT7i39a2EH2MYqnEAeZyRDsglyuUt8orBLzXtgDXo2N/wLUODDIXjL
 dib5SAmVL13ScXsZFIPQv5sOQQg/rZ2fydaD1pNpkL3UNpuQ2Xga1w9G2v7gzx+zKc/hK1mtH
 TD7UP7NX2CEN6Slp2i1OlWbZirYPdxhDYlPEed/cCkIpbBGAfjIF4Mrt+xW8JPcCixs3uTLSW
 4QjO7zRDQk8G7ta+j51QFHt4dNd8xETtTl8Gb4Y+mrA2jswjYU2p5Z7fk4K7k5HC8VE5j6ZXg
 lzxBH6QBqkHQu25ce1qyEI6PSDZd87KvA6uX6/rYNXfHmZKqD2tU/ZHsBf03+jiWcarLuiWus
 KCsZpRNgLrls8h9gfgJIghzIcupUrQD6yJ4iSMmBYyuGS3ptlttDcHQhIVcJMUS3MgoIICskP
 88Mu6CN2Hqekce5bCMyZzmQYsBD6CQsYIs0U+TM9OdjxPKVXB5sAKxB5o/bYZ+3SQnNIXr+4G
 AMktGc3/+E0Mi0aehT2IQ4J4GYQhLdBSIKvNTGuZnlxOdla0WJH02Lw7xFku3hZo//doi9ELb
 D7+gsX45VfbhfBfpfgGz1BApjGlOdbdX6RsEFi0YVbvNnB+mZvExSvg7UNNoERelH/6bBmEfI
 iQLd9eXXVAyFzI0EJtqgDYxsI7Wheo1SLn1bKECi7u+dNcOVTFQ2P/w+AJUbroD0pfEO8PvqL
 2twLeUsOFT1826HF93uY53ci4aA9n5zmEV8TMdtSKOhw6D71SK57tW4VF5HeYD0Ty2NMDMhmB
 ag4DFCaFvKuokzSe/FvRG4KpIfYeKHeeN3utcnVY0rKAv5f6u/qMcOeO9i+6ygRKxuA/h/p+I
 DyUf9fkUMxqPnJpnWvO97ojIR5ttFxVs0NGgtWTkDOLiiUai9dC7Kh/n6y2M5n3dfRQ9vIGJJ
 CpIDgZccJNFOjRbhHGUsNQ2lYXC7NsrcfbTGWt1k4yA9Fs6vQ2pf5JB+5yNyvfxKGHTQTC1Xp
 +OkYf8csjO08Qa1nz+Z7MYccQx2FTPOporlF5d/lFAsLryZSQ5U2UYnc90Y8WaOLqq1HcKbnQ
 VmoZzoJ9ksASYwoYowhm+FDexJXSD1w2aoBWJCRMfW59xD5/+/KAQwGNRKV/JOjHLlPaw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 31 Jul 2019, Junio C Hamano wrote:

> "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +struct item {
> > +	const char *name;
> > +};
> > +
> > +struct list_options {
> > +	const char *header;
> > +	void (*print_item)(int i, struct item *item, void *print_item_data);
> > +	void *print_item_data;
> > +};
> > +
> > +struct adddel {
> > +	uintmax_t add, del;
> > +	unsigned seen:1, binary:1;
> > +};
> > +
> > +struct file_list {
> > +	struct file_item {
> > +		struct item item;
> > +		struct adddel index, worktree;
> > +	} **file;
> > +	size_t nr, alloc;
> > +};
> > +
> > +struct pathname_entry {
> > +	struct hashmap_entry ent;
> > +	size_t index;
> > +	char pathname[FLEX_ARRAY];
> > +};
>
> All of the above are named too generic but assuming that add-i will
> stay to be a single file and these names will never leak outside the
> file to become global, it would be perfectly fine.

Yep.

> > +static void populate_wi_changes(struct strbuf *buf,
> > +				struct adddel *ad, const char *no_changes)
> > +{
> > +	if (ad->binary)
> > +		strbuf_addstr(buf, _("binary"));
> > +	else if (ad->seen)
> > +		strbuf_addf(buf, "+%"PRIuMAX"/-%"PRIuMAX,
> > +			    (uintmax_t)ad->add, (uintmax_t)ad->del);
> > +	else
> > +		strbuf_addstr(buf, no_changes);
> > +}
>
> I offhand do not see the need for (uintmax_t) casts here...

Ah, that's my mistake. I had converted the `add` and `del` fields from
the `unsigned long` data type that the 20th century wanted back.

> > +static int run_status(struct repository *r, const struct pathspec *ps=
,
> > +		      struct file_list *files, struct list_options *opts)
> > +{
> > +	reset_file_list(files);
> > +
> > +	if (get_modified_files(r, files, ps) < 0)
> > +		return -1;
> > +
> > +	if (files->nr)
> > +		list((struct item **)files->file, files->nr, opts);
> > +	putchar('\n');
>
> So, if there is anything to list, we show list() and then add an
> empty line; if there is nothing to list, we show an empty line
> anyway?
>
> As long as that matches the current scripted "add -i", it's
> perfectly fine.  It's just that the code structure above looked
> somewhat odd.

Yep, this is the Perl version:

sub status_cmd {
        list_and_choose({ LIST_ONLY =3D> 1, HEADER =3D> $status_head },
			list_modified());
	print "\n";
}

> > +static void collect_changes_cb(struct diff_queue_struct *q,
> > +			       struct diff_options *options,
> > +			       void *data)
> > +{
> > +	struct collection_status *s =3D data;
> > +	struct diffstat_t stat =3D { 0 };
> > +	int i;
> > +
> > +	if (!q->nr)
> > +		return;
> > +
> > +	compute_diffstat(options, &stat, q);
> > +
> > +	for (i =3D 0; i < stat.nr; i++) {
> > +		const char *name =3D stat.files[i]->name;
> > +		int hash =3D strhash(name);
> > +		struct pathname_entry *entry;
> > +		size_t file_index;
> > +		struct file_item *file;
> > +		struct adddel *adddel;
> > +
> > +		entry =3D hashmap_get_from_hash(&s->file_map, hash, name);
> > +		if (entry)
> > +			file_index =3D entry->index;
> > +		else {
> > +			FLEX_ALLOC_STR(entry, pathname, name);
> > +			hashmap_entry_init(entry, hash);
> > +			entry->index =3D file_index =3D s->list->nr;
> > +			hashmap_add(&s->file_map, entry);
> > +
> > +			add_file_item(s->list, name);
> > +		}
> > +		file =3D s->list->file[file_index];
> > +
> > +		adddel =3D s->phase =3D=3D FROM_INDEX ? &file->index : &file->workt=
ree;
> > +		adddel->seen =3D 1;
> > +		adddel->add =3D stat.files[i]->added;
> > +		adddel->del =3D stat.files[i]->deleted;
> > +		if (stat.files[i]->is_binary)
> > +			adddel->binary =3D 1;
> > +	}
> > +}
>
> Would resources held in the "stat" structure leak at the end of this
> function?

Yep, I added a call to the now-public `free_diffstat_info()` function.

Thanks,
Dscho
